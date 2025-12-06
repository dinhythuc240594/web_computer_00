package serviceimpl;

import config.MailConfig;
import jakarta.activation.DataHandler;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.mail.util.ByteArrayDataSource;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import model.EmailRequest;
import service.EmailService;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Properties;

public class SmtpEmailService implements EmailService {

    @Override
    public void send(ServletContext ctx, EmailRequest req, List<Part> attachments) throws Exception {
        Properties props = MailConfig.buildSmtpProps(ctx);
        final String username = props.getProperty("_username", "");
        final String password = props.getProperty("_password", "");

        Session session = Session.getInstance(props,
                (username != null && !username.isBlank())
                        ? new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                }
                        : null
        );

        MimeMessage message = new MimeMessage(session);

        // From
        String from = props.getProperty("mail.smtp.from", username);
        message.setFrom(new InternetAddress(parseAddress(from)));

        // To/CC/BCC
        addRecipients(message, Message.RecipientType.TO, req.getTo());
        addRecipients(message, Message.RecipientType.CC, req.getCc());
        addRecipients(message, Message.RecipientType.BCC, req.getBcc());

        message.setSubject(req.getSubject(), "UTF-8");

        // Body: ưu tiên multipart/mixed nếu có file đính kèm
        MimeMultipart mixed = new MimeMultipart("mixed");

        // Part body: nếu có cả text & html => multipart/alternative
        MimeBodyPart bodyPart = new MimeBodyPart();
        if (req.getHtmlBody() != null && !req.getHtmlBody().isBlank()
                && req.getTextBody() != null && !req.getTextBody().isBlank()) {
            MimeMultipart alt = new MimeMultipart("alternative");

            MimeBodyPart text = new MimeBodyPart();
            text.setText(req.getTextBody(), "UTF-8");
            alt.addBodyPart(text);

            MimeBodyPart html = new MimeBodyPart();
            html.setContent(req.getHtmlBody(), "text/html; charset=UTF-8");
            alt.addBodyPart(html);

            bodyPart.setContent(alt);
        } else if (req.getHtmlBody() != null && !req.getHtmlBody().isBlank()) {
            bodyPart.setContent(req.getHtmlBody(), "text/html; charset=UTF-8");
        } else {
            bodyPart.setText(req.getTextBody() != null ? req.getTextBody() : "", "UTF-8");
        }
        mixed.addBodyPart(bodyPart);

        // Attachments
        if (attachments != null) {
            for (Part p : attachments) {
                if (p == null || p.getSize() <= 0) continue;

                String fileName = p.getSubmittedFileName();
                if (fileName == null || fileName.isBlank()) fileName = "attachment";

                // Đọc toàn bộ vào byte[]
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                try (InputStream is = p.getInputStream()) {
                    is.transferTo(bos);
                }
                byte[] data = bos.toByteArray();

                // Content-Type fallback
                String contentType = p.getContentType();
                if (contentType == null || contentType.isBlank()) {
                    contentType = "application/octet-stream";
                }

                // Tạo DataSource từ byte[]
                ByteArrayDataSource ds = new ByteArrayDataSource(data, contentType);

                MimeBodyPart attach = new MimeBodyPart();
                attach.setDataHandler(new DataHandler(ds));
                attach.setFileName(MimeUtility.encodeText(fileName, "UTF-8", null));
                mixed.addBodyPart(attach);
            }
        }

        message.setContent(mixed);
        Transport.send(message);
    }

    private static void addRecipients(MimeMessage msg, Message.RecipientType type, List<String> list) throws MessagingException {
        if (list == null || list.isEmpty()) return;
        InternetAddress[] arr = list.stream()
                .filter(s -> s != null && !s.isBlank())
                .map(SmtpEmailService::parseAddress)
                .map(addr -> {
                    try { return new InternetAddress(addr, true); }
                    catch (Exception e) { return null; }
                })
                .filter(a -> a != null)
                .toArray(InternetAddress[]::new);
        if (arr.length > 0) msg.addRecipients(type, arr);
    }

    private static String parseAddress(String s) {
        // Chấp nhận dạng "Tên <email@domain>" hoặc chỉ "email@domain"
        return s.trim();
    }
}