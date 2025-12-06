package service;

import model.OrderDAO;

import java.util.List;

public interface OrderService extends Service<OrderDAO>{
    List<OrderDAO> findByUserId(int userId);
    List<OrderDAO> findByUserIdWithPagination(int userId, int offset, int limit);
    int countByUserId(int userId);
}
