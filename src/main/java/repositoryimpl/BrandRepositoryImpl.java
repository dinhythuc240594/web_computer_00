package repositoryimpl;

import model.BrandDAO;
import repository.BrandRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandRepositoryImpl implements BrandRepository {

    private final DataSource ds;

    public BrandRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<BrandDAO> getAll() {
        List<BrandDAO> items = new ArrayList<>();
        String sql = "SELECT id, name, code, is_active, logo_url FROM brands";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToBrandDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;
    }

    @Override
    public BrandDAO findById(int id) {

        String sql = "SELECT id, name, code, is_active, logo_url "
                + "FROM brands WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBrandDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm đơn hàng theo ID: " + id, e);
        }
        return null;
    }

    @Override
    public Boolean deleteById(int id) {

        String sql = "UPDATE brands SET is_active = ? WHERE id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, false);
            ps.setInt(2, id);

            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi delete: " + e.getMessage());
            return false;
        }
    }

    @Override
    public int count(String keyword) {
        return 0;
    }

    @Override
    public Boolean create(BrandDAO entity) {

        String sql = "INSERT INTO brands (name, code, is_active, logo_url) VALUES (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getCode());
            ps.setString(3, entity.getLogo_url());
            ps.setBoolean(4, entity.getIs_active());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Boolean update(BrandDAO entity) {

        String sql = "UPDATE brands SET name = ?, code = ?, is_active = ?, logo_url = ?"
                    + " WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getCode());
            ps.setString(3, entity.getLogo_url());
            ps.setBoolean(4, entity.getIs_active());
            ps.setInt(5, entity.getId());
            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;

    }

    private BrandDAO mapResultSetToBrandDAO(ResultSet rs) throws SQLException {
        BrandDAO item = new BrandDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setCode(rs.getString("code"));
        item.setIs_active(rs.getBoolean("is_active"));

        return item;
    }

}
