package repository;

import model.OrderDAO;
import model.PageRequest;

import java.util.List;

public interface OrderRepository extends Repository<OrderDAO>{
    List<OrderDAO> findByUserId(int userId);
    List<OrderDAO> findByUserIdWithPagination(int userId, int offset, int limit);
    int countByUserId(int userId);
    List<OrderDAO> findAll(PageRequest pageRequest);
    int count(String keyword);
}
