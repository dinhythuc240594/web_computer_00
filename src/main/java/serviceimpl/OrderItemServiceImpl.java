package serviceimpl;

import model.OrderItemDAO;
import model.PageRequest;
import repository.CategoryRepository;
import repository.OrderItemRepository;
import repositoryimpl.CategoryRepositoryImpl;
import repositoryimpl.OrderItemRepositoryImpl;
import service.OrderItemService;

import javax.sql.DataSource;
import java.util.List;

public class OrderItemServiceImpl implements OrderItemService {

    private OrderItemRepository orderItemRepository;

    public OrderItemServiceImpl(DataSource ds) {
        this.orderItemRepository = new OrderItemRepositoryImpl(ds);
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
    public Boolean create(OrderItemDAO entity) {
        return false;
    }

    @Override
    public Boolean update(OrderItemDAO entity) {
        return false;
    }
}
