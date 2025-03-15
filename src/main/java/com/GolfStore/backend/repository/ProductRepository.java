package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.Products;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {
    Page<Products> findByCategory_CategoryName(String categoryName, Pageable pageable);
}

