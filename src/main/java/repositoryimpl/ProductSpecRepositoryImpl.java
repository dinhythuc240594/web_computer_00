package repositoryimpl;

import model.PageRequest;
import model.ProductDAO;
import model.ProductSpecDAO;
import repository.ProductSpecRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProductSpecRepositoryImpl implements ProductSpecRepository {

    private final DataSource ds;

    public ProductSpecRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ProductSpecDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public ProductSpecDAO findById(int id) {

        String sql = "SELECT id, name, description, value,"
                    + " image_url, slug, category_id, stock_quantity, "
                    + " brand_id, is_active "
                    + "FROM product_specs WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProductSpecDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm đơn hàng theo ID: " + id, e);
        }
        return null;
    }

    public Boolean deleteById(int id){
        return false;
    }

    @Override
    public Boolean deleteByProductId(int id, int productId) {

        String sql = "DELETE FROM product_specs WHERE id = ? AND product_id = ?";;
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setInt(2, productId);

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Error delete: " + e.getMessage());
            return false;
        }

    }

    @Override
    public int count(String keyword) {
        return 0;
    }

    @Override
    public Boolean create(ProductSpecDAO entity) {
        return false;
    }

    @Override
    public Boolean update(ProductSpecDAO entity) {

        String sql = "UPDATE product_specs SET name = ?, description = ?, value = ?"
                    + " WHERE id = ? AND product_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setInt(3, entity.getValue());
            ps.setInt(4, entity.getId());
            ps.setInt(5, entity.getProductId());
            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Error update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    private ProductSpecDAO mapResultSetToProductSpecDAO(ResultSet rs) throws SQLException {
        ProductSpecDAO item = new ProductSpecDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setValue(rs.getInt("value"));
        item.setProductId(rs.getInt("product_id"));

        return item;
    }

}
