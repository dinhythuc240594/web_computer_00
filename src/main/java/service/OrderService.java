package service;

import model.OrderDAO;
import model.Page;
import model.PageRequest;

import java.util.List;

public interface OrderService extends Service<OrderDAO>{
    List<OrderDAO> findByUserId(int userId);
    List<OrderDAO> findByUserIdWithPagination(int userId, int offset, int limit);
    int countByUserId(int userId);
    Page<OrderDAO> findAll(PageRequest pageRequest);
}
