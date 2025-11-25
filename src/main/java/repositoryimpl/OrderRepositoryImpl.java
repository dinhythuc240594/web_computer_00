package repositoryimpl;

import model.OrderDAO;
import model.OrderItemDAO;
import model.PageRequest;
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

        String sql = "SELECT id, user_id, order_date, status, total_amount "
                    + "shipping_address, payment_method, note, is_active"
                    + " FROM orders";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToOrderOrderDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;
    }

    @Override
    public OrderDAO findById(int id) {

        String sql = "SELECT id, user_id, order_date, status, total_amount, shipping_address, "
                    + "payment_method, note, is_active "
                    + "FROM orders WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrderOrderDAO(rs);
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
        return 0;
    }

    @Override
    public Boolean create(OrderDAO entity) {

        String sql = "INSERT INTO categories (user_id, order_date, status, " +
                "total_amount, shipping_address, " +
                "payment_method, note, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Boolean update(OrderDAO entity) {

        String sql = "UPDATE orders SET user_id = ?, order_date = ?, status = ?, total_amount = ?, "
                    + "shipping_address = ?,  payment_method = ?, is_active = ? "
                    + "WHERE id = ?";

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

    private OrderDAO mapResultSetToOrderOrderDAO(ResultSet rs) throws SQLException {
        OrderDAO item = new OrderDAO();

        item.setId(rs.getInt("id"));
        item.setAddress(rs.getString("address"));
        item.setOrderDate(rs.getDate("order_date"));
        item.setNote(rs.getString("note"));
        item.setStatus(rs.getString("status"));
        item.setPayment(rs.getString("payment"));
        item.setTotalPrice(rs.getDouble("total_price"));

        return item;
    }

}
