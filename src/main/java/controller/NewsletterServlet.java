package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.EmailRequest;
import service.EmailService;
import serviceimpl.NewsletterServiceImpl;
import serviceimpl.SmtpEmailService;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet {

    private NewsletterServiceImpl newsletterService;
    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        super.init();
        newsletterService = new NewsletterServiceImpl();
        emailService = new SmtpEmailService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String action = request.getParameter("action"); // subscribe hoặc unsubscribe
        
        PrintWriter out = response.getWriter();
        
        try {
            if (email == null || email.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Email không được để trống\"}");
                return;
            }

            boolean success = false;
            String message = "";

            if ("unsubscribe".equals(action)) {
                success = newsletterService.unsubscribe(email);
                message = success ? "Đã hủy đăng ký newsletter thành công" : "Không tìm thấy email đăng ký";
            } else {
                // Mặc định là subscribe
                success = newsletterService.subscribe(email);
                if (success) {
                    message = "Đăng ký newsletter thành công! Cảm ơn bạn đã quan tâm.";
                    
                    // Gửi email xác nhận đăng ký
                    try {
                        EmailRequest emailRequest = createNewsletterConfirmationEmail(email);
                        emailService.send(getServletContext(), emailRequest, null);
                    } catch (Exception e) {
                        // Log lỗi nhưng không ảnh hưởng đến response
                        System.err.println("Lỗi khi gửi email xác nhận newsletter: " + e.getMessage());
                        e.printStackTrace();
                    }
                } else {
                    message = "Đã xảy ra lỗi. Vui lòng thử lại sau.";
                }
            }

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true, \"message\": \"" + message + "\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"" + message + "\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể dùng để hiển thị trang unsubscribe
        String email = request.getParameter("email");
        String token = request.getParameter("token"); // Có thể dùng token để bảo mật
        
        if (email != null) {
            boolean success = newsletterService.unsubscribe(email);
            if (success) {
                request.setAttribute("message", "Đã hủy đăng ký newsletter thành công!");
            } else {
                request.setAttribute("error", "Không tìm thấy email đăng ký hoặc đã hủy đăng ký trước đó.");
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/client/newsletter-unsubscribe.jsp").forward(request, response);
    }
    
    private EmailRequest createNewsletterConfirmationEmail(String email) {
        EmailRequest emailRequest = new EmailRequest();
        
        List<String> to = new ArrayList<>();
        to.add(email);
        emailRequest.setTo(to);
        
        emailRequest.setSubject("Cảm ơn bạn đã đăng ký nhận tin từ chúng tôi!");
        
        // HTML body
        String htmlBody = "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }" +
                ".button { display: inline-block; padding: 12px 30px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; color: #666; font-size: 12px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h1>🎉 Cảm ơn bạn đã đăng ký!</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Xin chào,</p>" +
                "<p>Cảm ơn bạn đã đăng ký nhận tin từ <strong>Computer Store</strong>!</p>" +
                "<p>Bạn sẽ nhận được những thông tin mới nhất về:</p>" +
                "<ul>" +
                "<li>📦 Sản phẩm mới và khuyến mãi đặc biệt</li>" +
                "<li>🎁 Chương trình giảm giá và flash sale</li>" +
                "<li>💡 Tin tức công nghệ và mẹo sử dụng</li>" +
                "<li>⭐ Đánh giá sản phẩm và hướng dẫn mua hàng</li>" +
                "</ul>" +
                "<p>Chúng tôi cam kết chỉ gửi những thông tin hữu ích và không spam email của bạn.</p>" +
                "<p>Nếu bạn muốn hủy đăng ký bất cứ lúc nào, vui lòng liên hệ với chúng tôi hoặc click vào link hủy đăng ký trong email.</p>" +
                "<p>Trân trọng,<br><strong>Đội ngũ Computer Store</strong></p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>© 2025 Computer Store. Tất cả quyền được bảo lưu.</p>" +
                "<p>Email này được gửi đến " + email + " vì bạn đã đăng ký nhận tin từ website của chúng tôi.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
        
        emailRequest.setHtmlBody(htmlBody);
        
        // Text body (fallback)
        String textBody = "Cảm ơn bạn đã đăng ký nhận tin từ Computer Store!\n\n" +
                "Bạn sẽ nhận được những thông tin mới nhất về:\n" +
                "- Sản phẩm mới và khuyến mãi đặc biệt\n" +
                "- Chương trình giảm giá và flash sale\n" +
                "- Tin tức công nghệ và mẹo sử dụng\n" +
                "- Đánh giá sản phẩm và hướng dẫn mua hàng\n\n" +
                "Chúng tôi cam kết chỉ gửi những thông tin hữu ích và không spam email của bạn.\n\n" +
                "Trân trọng,\nĐội ngũ Computer Store";
        
        emailRequest.setTextBody(textBody);
        
        return emailRequest;
    }
}

