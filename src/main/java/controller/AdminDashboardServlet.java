package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserDAO;
import service.UserService;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<UserDAO> adminUsers;
        try {
            adminUsers = userService.getAll();
        } catch (Exception ex) {
            adminUsers = java.util.Collections.emptyList();
        }
        request.setAttribute("adminUsers", adminUsers);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/dashboard/index.jsp");
        rd.forward(request, response);
    }
}


