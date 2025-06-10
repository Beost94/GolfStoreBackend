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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor

public class ProductService {
    private final ProductRepository productRepository;
    private final CategoryFilterOptionRepository categoryFilterOptionRepository;
    private final DTOMapper dtoMapper;

    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            ProductSearchCriteriaDTO criteria,
            int page,
            int size
    ) {
        //Bygger spørringen som skal bli brukt for å hente produkter basert på valgte filter.
        Specification<Product> spec = ProductSpecification.ProductCriteriaBuilder(criteria);

        //Lager pageable objektet, som skal holde styr på antall sider og antall rader for hver side.
        Pageable pageable = PageRequest.of(page, size);

        //Henter produkter for menuGrid, med den spesefikke spørringen og pageable.
        Page<Product> productPage = productRepository.findAll(spec, pageable);

        //Det vil hentes mange produkter og alle produktene som hentes på konverteres til DTO's.
        //Her itererer man over alle resultatene fra spørringen, og konverterer alle til en DTO, og legger disse inn i en liste.
        List<MenuGridProductDTO> dtos = productPage.getContent().stream()
                .map(dtoMapper::mapToDTOMenuGrid)
                .collect(Collectors.toList());

        //Endelige resultatet returneres. med pagination metadata og en liste med dto'er
        return PageResponseDTO.of(productPage, dtos);

    }

    public List<FilterOptionDTO> getFilterOptionsForCategory(String category) {
        if (category == null || category.isEmpty()) {
            throw new IllegalArgumentException("Category can not be empty");
        }
        List<CategoryFilterOption> categoryFilterOption = categoryFilterOptionRepository.findByCategory_CategoryName(category);
        if (categoryFilterOption.isEmpty()) {
            throw new EntityNotFoundException("No filter options found for category: " + category);
        }
        return dtoMapper.mapToDTOFilterOptions(categoryFilterOption);

    }

    public ProductWithVariantsDTO getProductWithVariants(Integer productid){
        Optional<Product> product = productRepository.findById(productid);
        if(product.isEmpty()){
            throw new EntityNotFoundException("Product not found");
        }

        List<FlatVariantsDTO> flatVariantsDTOS = productRepository.findVariantsByProductId(productid);

        return dtoMapper.mapToProductWithVariantsDTO(product.get(), flatVariantsDTOS);
    }

}



