package repositoryimpl;

import model.OrderDAO;
import repository.OrderRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepository {

    private final DataSource ds;

    public OrderRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderDAO> getAll() {

        List<OrderDAO> items = new ArrayList<>();

        String sql = "SELECT id, user_id, order_date, status, total_amount, " +
                "shipping_address, payment_method, note, is_active " +
                "FROM orders";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToOrderDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả đơn hàng.", e);
        }
        return items;
    }

    @Override
    public OrderDAO findById(int id) {

        String sql = "SELECT id, user_id, order_date, status, total_amount, shipping_address, " +
                "payment_method, note, is_active " +
                "FROM orders WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrderDAO(rs);
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

        String sql = "UPDATE orders SET is_active = ? WHERE id = ?";
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
        // Đếm tổng số đơn hàng, có thể mở rộng để hỗ trợ tìm kiếm theo keyword sau này
        String baseSql = "SELECT COUNT(1) FROM orders";
        StringBuilder sql = new StringBuilder(baseSql);
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();

        if (hasKeyword) {
            sql.append(" WHERE CAST(id AS CHAR) LIKE ? OR CAST(user_id AS CHAR) LIKE ?");
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(1, like);
                ps.setString(2, like);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Boolean create(OrderDAO entity) {

        String sql = "INSERT INTO orders (user_id, order_date, status, " +
                "total_amount, shipping_address, " +
                "payment_method, note, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, entity.getUser_id());
            ps.setDate(2, entity.getOrderDate());
            ps.setString(3, entity.getStatus());
            ps.setDouble(4, entity.getTotalPrice());
            ps.setString(5, entity.getAddress());
            ps.setString(6, entity.getPayment());
            ps.setString(7, entity.getNote());
            ps.setBoolean(8, entity.getIs_active());

            ps.executeUpdate();

            // Lấy ID vừa tạo
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    entity.setId(generatedKeys.getInt(1));
                }
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }
    
    public int createAndGetId(OrderDAO entity) {
        if (create(entity)) {
            return entity.getId();
        }
        return 0;
    }

    @Override
    public Boolean update(OrderDAO entity) {

        String sql = "UPDATE orders SET user_id = ?, order_date = ?, status = ?, total_amount = ?, " +
                "shipping_address = ?,  payment_method = ?, note = ?, is_active = ? " +
                "WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, entity.getUser_id());
            ps.setDate(2, entity.getOrderDate());
            ps.setString(3, entity.getStatus());
            ps.setDouble(4, entity.getTotalPrice());
            ps.setString(5, entity.getAddress());
            ps.setString(6, entity.getPayment());
            ps.setString(7, entity.getNote());
            ps.setBoolean(8, entity.getIs_active());
            ps.setInt(9, entity.getId());

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;


    }

    private OrderDAO mapResultSetToOrderDAO(ResultSet rs) throws SQLException {
        OrderDAO item = new OrderDAO();

        item.setId(rs.getInt("id"));
        item.setUser_id(rs.getInt("user_id"));
        item.setOrderDate(rs.getDate("order_date"));
        item.setStatus(rs.getString("status"));
        item.setTotalPrice(rs.getDouble("total_amount"));
        item.setAddress(rs.getString("shipping_address"));
        item.setPayment(rs.getString("payment_method"));
        item.setNote(rs.getString("note"));
        item.setIs_active(rs.getBoolean("is_active"));

        return item;
    }

}
