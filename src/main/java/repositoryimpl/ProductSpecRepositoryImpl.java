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
import java.util.ArrayList;
import java.util.List;

public class ProductSpecRepositoryImpl implements ProductSpecRepository {

    private final DataSource ds;

    public ProductSpecRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ProductSpecDAO> getAll() {
        List<ProductSpecDAO> items = new ArrayList<>();
        String sql = "SELECT id, product_id, spec_name, spec_value FROM product_specs";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToProductSpecDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;
    }

    @Override
    public ProductSpecDAO findById(int id){
        return null;
    }

    @Override
    public ProductSpecDAO findByProductId(int id, int productId) {

        String sql = "SELECT id, product_id, spec_name, spec_value "
                    + "FROM product_specs WHERE id = ? AND product_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
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

    @Override
    public List<ProductSpecDAO> findAllByProductId(int productId) {
        List<ProductSpecDAO> items = new ArrayList<>();
        String sql = "SELECT id, product_id, spec_name, spec_value FROM product_specs WHERE product_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToProductSpecDAO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy thông số kỹ thuật sản phẩm: " + productId, e);
        }
        return items;
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
        String sql = "INSERT INTO product_specs (spec_name, spec_value, product_id) VALUES (?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getvalueSpec());
            ps.setInt(3, entity.getProductId());

            ps.executeUpdate();

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi thêm chi tiết đơn hàng.", e);
        }
    }

    @Override
    public Boolean update(ProductSpecDAO entity) {

        String sql = "UPDATE product_specs SET name = ?, description = ?, value = ?"
                    + " WHERE id = ? AND product_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setString(3, entity.getvalueSpec());
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
        item.setName(rs.getString("spec_name"));
        item.setDescription(rs.getString("spec_name")); // Using spec_name as description if needed
        item.setvalueSpec(rs.getString("spec_value"));
        item.setProductId(rs.getInt("product_id"));

        return item;
    }

}
