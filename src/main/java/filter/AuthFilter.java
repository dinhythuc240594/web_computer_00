package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    private static final String[] STATIC_RESOURCE_EXTENSIONS = {
            ".css", ".js", ".jpg", ".jpeg", ".png", ".gif", ".ico", ".svg", ".woff", ".ttf", ".eot"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());
        if(path.equals("/")) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        String requestURI = req.getRequestURI().toLowerCase();
        boolean isStaticResource = false;
        for (String extension : STATIC_RESOURCE_EXTENSIONS) {
            if (requestURI.endsWith(extension)) {
                isStaticResource = true;
                break;
            }
        }

        if (isStaticResource) {
            chain.doFilter(request, response);
            return;
        }

        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession ses = req.getSession(false);

        boolean is_login = false;
        String username = "";
        String type_user = "";

        String userAvatar = null;
        if (ses != null) {
            Object isLoginAttr = ses.getAttribute("is_login");
            if (isLoginAttr != null) {
                is_login = (boolean) isLoginAttr;
                username = (String) ses.getAttribute("username");
                type_user = (String) ses.getAttribute("type_user");
                userAvatar = (String) ses.getAttribute("userAvatar");
            }
        }

        String[] protectedPaths = {"/order", "/profile", "/admin", "/product"};
        boolean isProtectedPath = false;

        // check path before redriect page
        if (path.startsWith("/cart")) {
            String action = req.getParameter("action");
            if (action != null && action.equals("checkout")) {
                isProtectedPath = true;
            } else {
                isProtectedPath = false;
            }
        } else if (path.startsWith("/foods")) {
            String action = req.getParameter("action");
            if (action == null || action.equals("list") || action.equals("detail")) {
                isProtectedPath = false;
            } else {
                isProtectedPath = true;
            }
        } else {
            for (String protectedPathItem : protectedPaths) {
                if (path.startsWith(protectedPathItem)) {
                    isProtectedPath = true;
                    break;
                }
            }
        }

        if (isProtectedPath && !is_login) {
            if (ses == null) {
                ses = req.getSession(true);
            }
            String requestedUrl = req.getRequestURI();
            String queryString = req.getQueryString();
            if (queryString != null) {
                requestedUrl += "?" + queryString;
            }
            ses.setAttribute("redirectAfterLogin", requestedUrl);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        request.setAttribute("is_login", is_login);
        request.setAttribute("username", username);
        request.setAttribute("type_user", type_user);
        request.setAttribute("userAvatar", userAvatar);
        System.out.println("AuthFilter: is_login=" + is_login + ", path=" + path);

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code
    }
}