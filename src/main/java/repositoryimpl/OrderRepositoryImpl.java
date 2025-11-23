package repositoryimpl;

import model.OrderDAO;
import repository.OrderRepository;

import javax.sql.DataSource;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepository {

    private final DataSource ds;

    public OrderRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<OrderDAO> getAll() {
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
    public OrderDAO create(OrderDAO entity) {
        return null;
    }

    @Override
    public OrderDAO update(OrderDAO entity) {
        return null;
    }
}
