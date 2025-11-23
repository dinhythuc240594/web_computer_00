package repositoryimpl;

import model.OrderItemDAO;
import repository.OrderItemRepository;

import javax.sql.DataSource;
import java.util.List;

public class OrderItemRepositoryImpl implements OrderItemRepository {

    private final DataSource ds;

    public OrderItemRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderItemDAO> getAll() {
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
    public OrderItemDAO create(OrderItemDAO entity) {
        return null;
    }

    @Override
    public OrderItemDAO update(OrderItemDAO entity) {
        return null;
    }
}
