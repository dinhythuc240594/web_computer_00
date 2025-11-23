package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/login")
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);

        if (session == null) {
            session = req.getSession(true);
        }
        String requestedUrl = req.getRequestURI();
        String queryString = req.getQueryString();
        if (queryString != null) {
            requestedUrl += "?" + queryString;
        }

        if (session.getAttribute("redirectAfterLogin") == null && !requestedUrl.contains("/login")) {
            session.setAttribute("redirectAfterLogin", requestedUrl);
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code
    }
}