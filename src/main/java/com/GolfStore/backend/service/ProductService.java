package com.GolfStore.backend.service;

import com.GolfStore.backend.DTOMapper.DTOMapper;
import com.GolfStore.backend.dto.*;
import com.GolfStore.backend.dto.ProductDTOs.AttributeDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductVariantDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductWithVariantsDTO;
import com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO;
import com.GolfStore.backend.model.*;
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
            for (VariantAttribute attr : variant.getVariantAttributes()) {
                String optionName = attr.getFilterOption().getFilterName();
                String value = attr.getFilterValue().getFiltervalueName();

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

    //VEELDIG EKSPERIMENTELT - DETTE SKAL FJERNES HVIS NY PRODUCTVARIANT METODE FUNKER ----------------

/*
  Henter tilgjengelige attributtverdier (hoved- og sekundæreattributter) for et gitt produkt.

  Bruk:
  - Hvis kun produktId er angitt: returner en liste over alle *hovedattributter* (f.eks. "Color", "Flex") som finnes blant variantene til produktet.
  - Hvis både produktId og én valgt hovedattributtverdi (f.eks. "Blue") er angitt: finn hvilke *sekundæreattributter* (f.eks. "Size", "Loft") som finnes
    blant variantene som har den valgte hovedattributtverdien.

  Eksempel:
  - Produkt 132 har varianter med attributter (Color: Blue, Size: Small), (Color: Blue, Size: Medium), (Color: Red, Size: Small)
    - Hvis "productId=132": returneres mainAttributes = ["Blue", "Red"]
    - Hvis "productId=132&mainAttribute=Blue": returneres secondaryAttributes = ["Small", "Medium"]
   */

    public GetAvailableAttributeValuesDTO getAvailableAttributeValues(FindAvailableAttributeValuesDTO dto) {
        Optional<Product> productOpt = productRepository.findById(dto.getProductId());
        if (productOpt.isEmpty()) {
            throw new EntityNotFoundException("Produkt ikke funnet for ID: " + dto.getProductId());
        }

        Product product = productOpt.get();
        List<ProductVariant> variants = product.getProductVariants();

        List<String> mainAttributeList = new ArrayList<>();
        List<String> secondaryAttributeList = new ArrayList<>();

        String mainAttributeName = null;
        String secondaryAttributeName = null;

        // Hent navnene på attributtene fra første variant
        if (!variants.isEmpty()) {
            List<VariantAttribute> firstAttributes = variants.get(0).getVariantAttributes();
            for (VariantAttribute attr : firstAttributes) {
                if (attr.getFilterOption().isMainAttribute()) {
                    mainAttributeName = attr.getFilterOption().getFilterName();
                } else {
                    secondaryAttributeName = attr.getFilterOption().getFilterName();
                }
            }
        }

        if (dto.getMainAttribute() == null || dto.getMainAttribute().isEmpty()) {
            Set<String> mainSet = new HashSet<>();

            for (ProductVariant variant : variants) {
                List<VariantAttribute> attributes = variant.getVariantAttributes();

                for (VariantAttribute attr : attributes) {
                    if (attr.getFilterOption().isMainAttribute()) {
                        String value = attr.getFilterValue().getFiltervalueName();
                        mainSet.add(value);
                    }
                }
            }

            mainAttributeList.addAll(mainSet);
        } else {
            Set<String> secondarySet = new HashSet<>();

            for (ProductVariant variant : variants) {
                boolean hasMainMatch = false;
                List<VariantAttribute> attributes = variant.getVariantAttributes();

                for (VariantAttribute attr : attributes) {
                    if (attr.getFilterOption().isMainAttribute()) {
                        String value = attr.getFilterValue().getFiltervalueName();
                        if (dto.getMainAttribute().contains(value)) {
                            hasMainMatch = true;
                            break;
                        }
                    }
                }

                if (hasMainMatch) {
                    for (VariantAttribute attr : attributes) {
                        if (!attr.getFilterOption().isMainAttribute()) {
                            String value = attr.getFilterValue().getFiltervalueName();
                            secondarySet.add(value);
                        }
                    }
                }
            }

            secondaryAttributeList.addAll(secondarySet);
        }

        return new GetAvailableAttributeValuesDTO(
                mainAttributeName,
                secondaryAttributeName,
                mainAttributeList,
                secondaryAttributeList
        );
    }

    public Integer getVariant(GetVariantDTO getVariantDTO){

        Integer productId = getVariantDTO.getProductId();
        String mainAttribute = getVariantDTO.getMainAttribute();
        String secondaryAttribute = getVariantDTO.getSecondaryAttribute();

        Optional<Product> product = productRepository.findById(productId);
        //
        if(product.isPresent()){
            //Gets a list of all the products variants.
            List<ProductVariant> productVariants = product.get().getProductVariants();
            //Iterates over all the productvariants to gather a list of each productvariants filterValuenames(Blue, Large, Stiff Flex etc)
            for(ProductVariant productVariant: productVariants){
                //Mapper makes it so we get the filterValueNames from each variantattribute, instead of the entire object.
                //attr is the variantattribute object, "map that object into a string with the value of filtername from that object instead"
                List<String> filterValueNames = productVariant.getVariantAttributes().stream().map(attr -> attr.getFilterValue().getFiltervalueName()).collect(Collectors.toList());

                if(filterValueNames.contains(mainAttribute) && filterValueNames.contains(secondaryAttribute)){
                    return productVariant.getVariantId();
                }

            }
        }
        throw new EntityNotFoundException("Fant ingen variant med begge attributtene");

    }
// ------------------------------------------------------------------------

    //Hvis denne funker, er det denne som skal brukes til å hente produkt info, og alle varianter.

    public ProductWithVariantsDTO getProductWithVariants(Integer productid){

        //Gets the rows of data from the repository.
        List<FlatVariantsDTO> flatVariantsDTOS = productRepository.findVariantsByProductId(productid);
        Optional<Product> product = productRepository.findById(productid);
        if(product.isEmpty()){
            throw new EntityNotFoundException("Product not found");
        }

        //Manually sets general info about the product.
        ProductWithVariantsDTO productWithVariantsDTO = new ProductWithVariantsDTO();
        productWithVariantsDTO.setProductName(product.get().getProductName());
        productWithVariantsDTO.setPrice(product.get().getPrice());
        productWithVariantsDTO.setDescription(product.get().getDescription());
        productWithVariantsDTO.setImageUrls(
                product.get().getImages().stream().map(Images::getImageUrl).toList());


        //Nå trenger vi å fylle en variant liste, for å legge inn i product

        Map<Integer, List<AttributeDTO>> variantMap = new LinkedHashMap<>();

        //Groups attributes by variantId
        for (FlatVariantsDTO row : flatVariantsDTOS){
            Integer variantId = row.getVariantId();
            AttributeDTO attributeDTO = new AttributeDTO(
                    row.getAttributeName(),
                    row.getAttributeValue(),
                    row.isMainAttribute()
            );

            //Checks if a key with variantId exist, if not, make a new key value pair for it.
            if (!variantMap.containsKey(variantId)){
                variantMap.put(variantId, new ArrayList<>());
            }
            //puts the list of attributes in that key value pair.
            variantMap.get(variantId).add(attributeDTO);
        }

        //Now to build a list of ProductVariantDTO's
        List<ProductVariantDTO> productVariantDTOS = new ArrayList<>();
        for (Map.Entry<Integer, List<AttributeDTO>> entry : variantMap.entrySet()) {
            productVariantDTOS.add(new ProductVariantDTO(entry.getKey(), entry.getValue()));
        }

        productWithVariantsDTO.setVariants(productVariantDTOS);

        return productWithVariantsDTO;


    }

}



