package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.FilterOptionDTO;
import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.service.ProductService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
@CrossOrigin(origins = "*")
public class ProductController {

    private final ProductService productService;


    public ProductController(ProductService productService) {
        this.productService = productService;

    }


    @GetMapping("/MenuGrid")
    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) List<String> size,
            @RequestParam(required = false) List<String> color,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int sizePerPage
    ) {
        return productService.getProductsForMenuGrid(category, brand, minPrice, maxPrice, size, color, page, sizePerPage);
    }


    /**
     * Henter full detaljert informasjon for et spesifikt produkt.
     */
    @GetMapping("/detail/{productId}")
    public ProductDetailDTO getProductForProductDetail(@PathVariable Integer productId) {
        return productService.getProductsForProductDetail(productId);
    }
    @GetMapping("/filteroptions")
    public List<FilterOptionDTO> getFilterOptionsForCategory(@RequestParam String category){
        return productService.getFilterOptionsForCategory(category);

    }





}
