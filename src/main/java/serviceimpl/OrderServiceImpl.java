package serviceimpl;

import model.OrderDAO;
import repository.OrderRepository;
import repositoryimpl.OrderRepositoryImpl;
import service.OrderService;

import javax.sql.DataSource;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;

    public OrderServiceImpl(DataSource ds) {
        this.orderRepository = new OrderRepositoryImpl(ds);
    }

    @Override
    public List<OrderDAO> getAll() {
        return orderRepository.getAll();
    }

    @Override
    public OrderDAO findById(int id) {
        return orderRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return orderRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return orderRepository.count(keyword);
    }

    @Override
    public Boolean create(OrderDAO entity) {
        return orderRepository.create(entity);
    }

    @Override
    public Boolean update(OrderDAO entity) {
        return orderRepository.update(entity);
    }

    @Override
    public List<OrderDAO> findByUserId(int userId) {
        return orderRepository.findByUserId(userId);
    }
}
