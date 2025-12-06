package repository;

import model.OrderDAO;

import java.util.List;

public interface OrderRepository extends Repository<OrderDAO>{
    List<OrderDAO> findByUserId(int userId);
}
