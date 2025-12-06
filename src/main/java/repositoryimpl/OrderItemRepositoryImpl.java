package repositoryimpl;

import model.CategoryDAO;
import model.OrderItemDAO;
import model.PageRequest;
import repository.OrderItemRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemRepositoryImpl implements OrderItemRepository {

    private final DataSource ds;

    public OrderItemRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderItemDAO> getAll() {

        List<OrderItemDAO> items = new ArrayList<>();
        String sql = "SELECT id, order_id, product_id, quantity, price_at_purchase FROM order_items";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToOrderItemDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;

    }

    @Override
    public OrderItemDAO findById(int id) {
        return null;
    }

    @Override
    public Boolean deleteById(int id) {
        return null;
    }

    @Override
    public int count(String keyword) {
        return 0;
    }

    @Override
    public Boolean create(OrderItemDAO entity) {

        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, entity.getOrderId());
            ps.setInt(2, entity.getProductId());
            ps.setInt(3, entity.getQuantity());
            ps.setDouble(4, entity.getPrice());

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi create order item: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Boolean update(OrderItemDAO entity) {

        String sql = "UPDATE order_items SET order_id = ?, product_id = ?, "
                    + "quantity = ?, price_at_purchase = ?"
                    + " WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setInt(1, entity.getOrderId());
            ps.setInt(2, entity.getProductId());
            ps.setInt(3, entity.getQuantity());
            ps.setDouble(4, entity.getPrice());
            ps.setInt(5, entity.getId());
            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;

    }

    private OrderItemDAO mapResultSetToOrderItemDAO(ResultSet rs) throws SQLException {
        OrderItemDAO item = new OrderItemDAO();

        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getDouble("price_at_purchase"));

        return item;
    }
}
