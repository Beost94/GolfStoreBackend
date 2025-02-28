package com.GolfStore.backend.controller;

import com.GolfStore.backend.model.Products;
import com.GolfStore.backend.service.ProductsService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products") // Base URL for product-related API calls
public class ProductsController {

    private final ProductsService productsService;

    public ProductsController(ProductsService productsService) {
        this.productsService = productsService;
    }

    // GET /api/products → Fetch all products
    @GetMapping
    public List<Products> getAllProducts() {
        return productsService.getAllProducts();
    }

}



