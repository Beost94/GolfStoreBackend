package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.CategoryFilterOption;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryFilterOptionRepository extends JpaRepository<CategoryFilterOption, Integer> {
    List<CategoryFilterOption> findByCategory_CategoryName(String categoryName);
}

