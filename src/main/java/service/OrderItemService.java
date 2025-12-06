package service;

import model.OrderItemDAO;

import java.util.List;

public interface OrderItemService extends Service<OrderItemDAO>{
    List<OrderItemDAO> findByOrderId(int orderId);
}
