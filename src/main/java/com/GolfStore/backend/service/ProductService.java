package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.FilterOptionDTO;
import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.model.CategoryFilterOption;
import com.GolfStore.backend.model.FilterValue;
import com.GolfStore.backend.model.Images;
import com.GolfStore.backend.model.Product;
import com.GolfStore.backend.repository.CategoryFilterOptionRepository;
import com.GolfStore.backend.repository.ProductRepository;
import com.GolfStore.backend.specifications.ProductSpecification;
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
            String category,
            String brand,
            Double minPrice,
            Double maxPrice,
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
        if (minPrice != null || maxPrice != null){
            spec = spec.and(ProductSpecification.hasPriceBetween(minPrice,maxPrice));

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
        List<CategoryFilterOption> categoryFilterOption = categoryFilterOptionRepository.findByCategory_CategoryName(category);

        return convertToFilterOptionDTO(categoryFilterOption);

        }





    }

