package com.GolfStore.backend.service;

import com.GolfStore.backend.DTOMapper.DTOMapper;
import com.GolfStore.backend.dto.FilterDTOs.FilterOptionDTO;
import com.GolfStore.backend.dto.ProductDTOs.MenuGridProductDTO;
import com.GolfStore.backend.dto.ProductDTOs.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductSearchCriteriaDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductWithVariantsDTO;
import com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO;
import com.GolfStore.backend.model.CategoryFilterOption;
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
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor


public class ProductService {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ProductService.class);
    private final ProductRepository productRepository;
    private final CategoryFilterOptionRepository categoryFilterOptionRepository;
    private final DTOMapper dtoMapper;

    @Transactional(readOnly = true)
    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            ProductSearchCriteriaDTO criteria,
            int page,
            int size
    ) {
        log.info("Fetching products for MenuGrid with criteria: {}, page: {}, size: {}", criteria, page, size);

        //Bygger spørringen som skal bli brukt for å hente produkter basert på valgte filter.
        Specification<Product> spec = ProductSpecification.ProductCriteriaBuilder(criteria);

        //Lager pageable objektet, som skal holde styr på antall sider og antall rader for hver side.
        Pageable pageable = PageRequest.of(page, size);

        //Henter produkter for menuGrid, med den spesefikke spørringen og pageable.
        Page<Product> productPage = productRepository.findAll(spec, pageable);
        log.info("Found {} products for given criteria", productPage.getTotalElements());


        //Det vil hentes mange produkter og alle produktene som hentes på konverteres til DTO's.
        //Her itererer man over alle resultatene fra spørringen, og konverterer alle til en DTO, og legger disse inn i en liste.
        List<MenuGridProductDTO> dtos = productPage.getContent().stream()
                .map(dtoMapper::mapToDTOMenuGrid)
                .collect(Collectors.toList());

        //Endelige resultatet returneres. med pagination metadata og en liste med dto'er
        return PageResponseDTO.of(productPage, dtos);

    }

    @Transactional(readOnly = true)
    public List<FilterOptionDTO> getFilterOptionsForCategory(String category) {
        log.info("Retrieving filter options for category: '{}'", category);
        if (category == null || category.isBlank()) {
            throw new IllegalArgumentException("Category must not be blank");
        }
        List<CategoryFilterOption> categoryFilterOption = categoryFilterOptionRepository.findByCategory_CategoryName(category);
        if (categoryFilterOption.isEmpty()) {
            log.warn("No filter options found for category: '{}'", category);
            throw new EntityNotFoundException("No filter options found for category: " + category);

        }
        log.info("Mapped {} filter options for category: '{}'", categoryFilterOption.size(), category);

        return dtoMapper.mapToDTOFilterOptions(categoryFilterOption);

    }

    @Transactional(readOnly = true)
    public ProductWithVariantsDTO getProductWithVariants(Integer productid) {
        log.info("Fetching product details with variants for product ID: {}", productid);
        Product product = productRepository.findById(productid)
                .orElseThrow(() -> new EntityNotFoundException("product with productid: " + productid + " not found."));

        List<FlatVariantsDTO> flatVariantsDTOS = productRepository.findVariantsByProductId(productid);
        log.info("Found {} variant rows for product ID {}", flatVariantsDTOS.size(), productid);
        log.debug("Mapped product and variants to ProductWithVariantsDTO");

        ProductWithVariantsDTO productWithVariantsDTO = dtoMapper.mapToProductWithVariantsDTO(product, flatVariantsDTOS);
        log.debug("Mapped product and variants to DTO: {}", productWithVariantsDTO.getProductId());
        return productWithVariantsDTO;
    }

}







