package repositoryimpl;

import model.OrderDAO;
import model.OrderItemDAO;
import model.PageRequest;
import repository.OrderRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepository {

    private final DataSource ds;

    public OrderRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public OrderDAO findById(int id) {
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
    public Boolean create(OrderDAO entity) {
        return false;
    }

    @Override
    public OrderDAO update(OrderDAO entity) {
        return null;
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
