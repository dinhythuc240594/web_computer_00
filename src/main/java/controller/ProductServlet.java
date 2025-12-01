package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductDAO;
import repository.ProductRepository;
import repositoryimpl.ProductRepositoryImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet(name="product", urlPatterns="/product")
public class ProductServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient ProductRepository productRepository;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productRepository = new ProductRepositoryImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Ưu tiên slug, fallback sang id
        String slug = request.getParameter("slug");
        String idParam = request.getParameter("id");

        ProductDAO product = null;
        if (slug != null && !slug.isBlank()) {
            product = productRepository.findBySlug(slug);
        } else if (idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam);
                product = productRepository.findById(id);
            } catch (NumberFormatException ex) {
                product = null;
            }
        }

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            return;
        }

        request.setAttribute("product", product);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/product-detail.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}