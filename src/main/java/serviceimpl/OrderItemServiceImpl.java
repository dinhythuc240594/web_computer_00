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
    public OrderItemDAO create(OrderItemDAO entity) {
        return null;
    }

    @Override
    public OrderItemDAO update(OrderItemDAO entity) {
        return null;
    }
}
