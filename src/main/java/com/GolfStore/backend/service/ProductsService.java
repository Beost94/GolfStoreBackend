package com.GolfStore.backend.service;

import com.GolfStore.backend.model.Products;
import com.GolfStore.backend.repository.ProductsRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductsService {
    private final ProductsRepository productsRepository;

    // Constructor injection (Spring automatically provides the repository)
    public ProductsService(ProductsRepository productsRepository) {
        this.productsRepository = productsRepository;
    }

    // Method to fetch all products
    public List<Products> getAllProducts() {
        return productsRepository.findAll();
    }
}
