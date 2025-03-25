package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.model.Images;
import com.GolfStore.backend.model.Product;
import com.GolfStore.backend.repository.ProductRepository;
import com.GolfStore.backend.specifications.ProductSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            String category,
            String brand,
            List<String> sizes,
            List<String> colors,
            int page,
            int size
    )
    {

        Specification<Product> spec = Specification.where(null);

        if (category != null) {
            spec = spec.and(ProductSpecification.hasCategory(category));
        }

        if (brand != null) {
            spec = spec.and(ProductSpecification.hasBrand(brand));
        }

        if (sizes != null && !sizes.isEmpty()) {
            spec = spec.and(ProductSpecification.hasVariantAttribute("Size", sizes));
        }

        if (colors != null && !colors.isEmpty()) {
            spec = spec.and(ProductSpecification.hasVariantAttribute("Color", colors));
        }


        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage = productRepository.findAll(spec, pageable);

        List<MenuGridProductDTO> dtos = productPage.getContent().stream()
                .map(this::convertToMenuGridDTO)
                .collect(Collectors.toList());

        return PageResponseDTO.of(productPage, dtos);
    }

    public ProductDetailDTO getProductsForProductDetail(Integer productId) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            throw new IllegalArgumentException("Produkt ikke funnet for ID: " + productId);
        }
        return convertToProductDetailDTO(productOpt.get());
    }

    private MenuGridProductDTO convertToMenuGridDTO(Product product) {
        return new MenuGridProductDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getBrand().getBrandName(),
                !product.getImages().isEmpty() ? product.getImages().get(0).getImageUrl() : null
        );
    }

    private ProductDetailDTO convertToProductDetailDTO(Product product) {
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
