package repository;

import model.BrandDAO;
import model.PageRequest;

import java.util.List;

public interface BrandRepository extends Repository<BrandDAO>{
    List<BrandDAO> findAll(PageRequest pageRequest);
    int count(String keyword);
}
