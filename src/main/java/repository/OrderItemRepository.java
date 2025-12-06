package repository;

import model.OrderItemDAO;

import java.util.List;

public interface OrderItemRepository extends Repository<OrderItemDAO>{
    List<OrderItemDAO> findByOrderId(int orderId);
}
