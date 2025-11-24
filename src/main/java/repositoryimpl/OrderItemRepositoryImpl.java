package repositoryimpl;

import model.CategoryDAO;
import model.OrderItemDAO;
import model.PageRequest;
import repository.OrderItemRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class OrderItemRepositoryImpl implements OrderItemRepository {

    private final DataSource ds;

    public OrderItemRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderItemDAO> getAll(PageRequest pageRequest) {
        return List.of();
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
        return false;
    }

    @Override
    public OrderItemDAO update(OrderItemDAO entity) {
        return null;
    }

    private OrderItemDAO mapResultSetToOrderItemDAO(ResultSet rs) throws SQLException {
        OrderItemDAO item = new OrderItemDAO();

        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getDouble("price"));

        return item;
    }
}
