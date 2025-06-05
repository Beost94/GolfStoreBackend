package com.GolfStore.backend.service;

import com.GolfStore.backend.DTOMapper.DTOMapper;
import com.GolfStore.backend.dto.*;
import com.GolfStore.backend.model.CategoryFilterOption;
import com.GolfStore.backend.model.Product;
import com.GolfStore.backend.model.ProductVariant;
import com.GolfStore.backend.model.VariantAttribute;
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

import java.util.*;
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
    public ProductDetailDTO getProductsForProductDetail(Integer productId) {
        //Henter produkt med gitt product id fra productRepository.
        //Bruker Optional wrapper for å sikre oss mot null feil.
        Optional<Product> productOpt = productRepository.findById(productId);
        //Sjekker om det faktisk fant noe i databasen, hvis den ikke finner kaster den en feilmelding
        if (productOpt.isEmpty()) {
            throw new EntityNotFoundException("Produkt ikke funnet for ID: " + productId);
        }
        //Hvis man finner et produkt med gitt produkt id, konverteres dette til en DTO og returneres til controller
        return dtoMapper.mapToDTOProductDetail(productOpt.get());
    }

    public List<FilterOptionDTO> getFilterOptionsForCategory(String category){
        if (category == null || category.isEmpty()){
            throw new IllegalArgumentException("Category can not be empty");
        }
        List<CategoryFilterOption> categoryFilterOption = categoryFilterOptionRepository.findByCategory_CategoryName(category);
        if(categoryFilterOption.isEmpty()){
            throw new EntityNotFoundException("No filter options found for category: " + category);
        }
        return dtoMapper.mapToDTOFilterOptions(categoryFilterOption);

        }



        //EKSPERIMENTELT

    public Map<String, List<String>> getAvailableFilterValuesForProduct(Integer productId) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            throw new EntityNotFoundException("Produkt ikke funnet for ID: " + productId);
        }

        Product product = productOpt.get();
        List<ProductVariant> variants = product.getProductVariants();

        Map<String, Set<String>> tempMap = new HashMap<>();

        for (ProductVariant variant : variants) {
            for (VariantAttribute attr : variant.getAttributes()) {
                String optionName = attr.getFilterOption().getFilterName();
                String value = attr.getFilterValue().getFilterValue();

                tempMap.computeIfAbsent(optionName, k -> new HashSet<>()).add(value);
            }
        }

        // Konverterer Set til List for responsen
        Map<String, List<String>> result = new HashMap<>();
        for (Map.Entry<String, Set<String>> entry : tempMap.entrySet()) {
            result.put(entry.getKey(), new ArrayList<>(entry.getValue()));
        }

        return result;
    }


    }


