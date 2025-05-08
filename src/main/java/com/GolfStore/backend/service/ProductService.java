package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.*;
import com.GolfStore.backend.model.CategoryFilterOption;
import com.GolfStore.backend.model.FilterValue;
import com.GolfStore.backend.model.Images;
import com.GolfStore.backend.model.Product;
import com.GolfStore.backend.repository.CategoryFilterOptionRepository;
import com.GolfStore.backend.repository.ProductRepository;
import com.GolfStore.backend.specifications.ProductSpecification;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor

public class ProductService {
    private final ProductRepository productRepository;
    private final CategoryFilterOptionRepository categoryFilterOptionRepository;

    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            ProductSearchCriteriaDTO criteria,
            int page,
            int size
    ) {
        try {
            Specification<Product> spec = Specification.where(null);
            if (criteria.getCategory() != null) {
                spec = spec.and(ProductSpecification.hasCategory(criteria.getCategory()));
            }

            if (criteria.getBrand() != null && !criteria.getBrand().isEmpty()) {
                spec = spec.and(ProductSpecification.hasAnyBrand(criteria.getBrand()));
            }

            if (criteria.getSize() != null && !criteria.getSize().isEmpty()) {
                spec = spec.and(ProductSpecification.hasVariantAttribute("Size", criteria.getSize()));
            }

            if (criteria.getColor() != null && !criteria.getColor().isEmpty()) {
                spec = spec.and(ProductSpecification.hasVariantAttribute("Color", criteria.getColor()));
            }
            if (criteria.getMinPrice() != null || criteria.getMaxPrice() != null) {
                spec = spec.and(ProductSpecification.hasPriceBetween(criteria.getMinPrice(), criteria.getMaxPrice()));

            }
            Pageable pageable = PageRequest.of(page, size);
            Page<Product> productPage = productRepository.findAll(spec, pageable);



            List<MenuGridProductDTO> dtos = productPage.getContent().stream()
                    .map(this::convertToMenuGridDTO)
                    .collect(Collectors.toList());

            return PageResponseDTO.of(productPage, dtos);
        }
        catch (EntityNotFoundException e){
            throw e;
        }
        catch (Exception e){
            throw new RuntimeException("Something went wrong fetching product", e);
        }
    }
    public ProductDetailDTO getProductsForProductDetail(Integer productId) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            throw new EntityNotFoundException("Produkt ikke funnet for ID: " + productId);
        }
        return convertToProductDetailDTO(productOpt.get());
    }

    private MenuGridProductDTO convertToMenuGridDTO(Product product) {
        if(product == null){
            throw new IllegalArgumentException("Product cant be null");
        }
        return new MenuGridProductDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getBrand().getBrandName(),
                !product.getImages().isEmpty() ? product.getImages().get(0).getImageUrl() : null
        );
    }

    private ProductDetailDTO convertToProductDetailDTO(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cant be null");
        }
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

    public List<FilterOptionDTO> convertToFilterOptionDTO(List<CategoryFilterOption> cfos){
        List<FilterOptionDTO> filterOptionDTOList = new ArrayList<>();

        for(CategoryFilterOption cfo: cfos){
            FilterOptionDTO filterOptionDTO = new FilterOptionDTO(
                    cfo.getFilterOption().getFilterName(),
                    cfo.getFilterOption().getFilterValues()
                            .stream().map(FilterValue::getFilterValue)
                            .collect(Collectors.toList())
            );
            filterOptionDTOList.add(filterOptionDTO);
        }
        return filterOptionDTOList;

    }

    public List<FilterOptionDTO> getFilterOptionsForCategory(String category){
        if (category == null || category.isEmpty()){
            throw new IllegalArgumentException("Category can not be empty");
        }
        List<CategoryFilterOption> categoryFilterOption = categoryFilterOptionRepository.findByCategory_CategoryName(category);
        if(categoryFilterOption.isEmpty()){
            throw new EntityNotFoundException("No filter options found for category: " + category);
        }

        return convertToFilterOptionDTO(categoryFilterOption);

        }
    }

