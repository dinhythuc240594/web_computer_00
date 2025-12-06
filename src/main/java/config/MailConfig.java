package config;

import jakarta.servlet.ServletContext;

import java.util.Properties;

public class MailConfig {

    public static Properties buildSmtpProps(ServletContext ctx) {
        Properties p = new Properties();

        String host = envOrCtx("MAIL_SMTP_HOST", ctx, "mail.smtp.host", "localhost");
        String port = envOrCtx("MAIL_SMTP_PORT", ctx, "mail.smtp.port", "25");
        String user = envOrCtx("MAIL_SMTP_USERNAME", ctx, "mail.smtp.username", "");
        String pass = envOrCtx("MAIL_SMTP_PASSWORD", ctx, "mail.smtp.password", "");
        String from = envOrCtx("MAIL_SMTP_FROM", ctx, "mail.smtp.from", user);
        String auth = envOrCtx("MAIL_SMTP_AUTH", ctx, "mail.smtp.auth", "true");
        String starttls = envOrCtx("MAIL_SMTP_STARTTLS", ctx, "mail.smtp.starttls.enable", "true");
        String sslEnable = envOrCtx("MAIL_SMTP_SSL_ENABLE", ctx, "mail.smtp.ssl.enable", "false");

        p.put("mail.debug", "true"); // in log giao tiếp SMTP
        p.put("mail.smtp.connectiontimeout", "15000");
        p.put("mail.smtp.timeout", "20000");
        p.put("mail.smtp.writetimeout", "20000");
        p.put("mail.smtp.host", host);
        p.put("mail.smtp.port", port);
        p.put("mail.smtp.auth", auth);
        p.put("mail.smtp.starttls.enable", starttls);
        p.put("mail.smtp.ssl.enable", sslEnable);
        p.put("mail.smtp.from", from);

        // nhét username/password để tiện truyền tiếp
        p.put("_username", user);
        p.put("_password", pass);

        return p;
    }

    private static String envOrCtx(String envKey, ServletContext ctx, String ctxKey, String defVal) {
        String v = System.getenv(envKey);
        if (v != null && !v.isBlank()) return v;
        String c = ctx.getInitParameter(ctxKey);
        if (c != null && !c.isBlank()) return c;
        return defVal;
    }
}