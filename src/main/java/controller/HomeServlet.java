package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PageRequest;
import serviceimpl.CategoryServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;
import utilities.RequestUtil;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet(name="home", urlPatterns="/home")
public class HomeServlet extends HttpServlet {

    private ProductServiceImpl productServiceImpl;
    private CategoryServiceImpl categoryServiceImpl;
    private int PAGE_SIZE = 25;

    @Override
    public void init() throws ServletException {
        DataSource ds = DataSourceUtil.getDataSource();
        this.productServiceImpl = new ProductServiceImpl(ds);
        this.categoryServiceImpl = new CategoryServiceImpl(ds);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String keyword = RequestUtil.getString(request, "keyword", "");
        String sortField = RequestUtil.getString(request, "sortField", "name");
        String orderField = RequestUtil.getString(request, "orderField", "ASC");
        int page = RequestUtil.getInt(request, "page", 1);

        PageRequest pageReq = new PageRequest(page, PAGE_SIZE, sortField, orderField, keyword);

        RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
        rd.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}