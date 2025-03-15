package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.model.Products;
import com.GolfStore.backend.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.GolfStore.backend.model.Images;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(String category, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Products> productPage = productRepository.findByCategory_CategoryName(category, pageable);

        List<MenuGridProductDTO> dtos = productPage.getContent().stream()
                .map(this::convertToMenuGridDTO)
                .collect(Collectors.toList());

        return PageResponseDTO.of(productPage, dtos);
    }

    public ProductDetailDTO getProductsForProductDetail(Integer productId) {
        Optional<Products> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            throw new IllegalArgumentException("Produkt ikke funnet for ID: " + productId);
        }
        return convertToProductDetailDTO(productOpt.get());
    }

    private MenuGridProductDTO convertToMenuGridDTO(Products product) {
        return new MenuGridProductDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getBrand().getBrandName(),
                !product.getImages().isEmpty() ? product.getImages().get(0).getImageUrl() : null
        );
    }

    private ProductDetailDTO convertToProductDetailDTO(Products product) {
        return new ProductDetailDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getDescription(),
                product.getBrand().getBrandName(),
                product.getCategory().getCategoryName(),
                product.getHasVariants(),
                product.getImages().stream()
                        .map(Images::getImageUrl) //
                        .collect(Collectors.toList())
        );
    }
}
