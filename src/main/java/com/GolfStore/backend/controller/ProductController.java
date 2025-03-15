package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.service.ProductService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/products")
@CrossOrigin(origins = "*")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    /**
     * Henter produkter for menugrid basert på kategori.
     */
    @GetMapping
    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            @RequestParam String category,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        return productService.getProductsForMenuGrid(category, page, size);
    }


    /**
     * Henter full detaljert informasjon for et spesifikt produkt.
     */
    @GetMapping("/{productId}")
    public ProductDetailDTO getProductForProductDetail(@PathVariable Integer productId) {
        return productService.getProductsForProductDetail(productId);
    }
}
