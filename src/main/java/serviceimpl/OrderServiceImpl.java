package serviceimpl;

import model.OrderDAO;
import model.PageRequest;
import repository.OrderItemRepository;
import repository.OrderRepository;
import repositoryimpl.OrderItemRepositoryImpl;
import repositoryimpl.OrderRepositoryImpl;
import service.OrderService;

import javax.sql.DataSource;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderRepository orderRepository;

    public OrderServiceImpl(DataSource ds) {
        this.orderRepository = new OrderRepositoryImpl(ds);
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
    public Boolean create(OrderDAO entity) {
        return null;
    }

    @Override
    public OrderDAO update(OrderDAO entity) {
        return null;
    }
}
