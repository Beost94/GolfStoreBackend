package com.GolfStore.backend.specifications;


import com.GolfStore.backend.dto.ProductSearchCriteriaDTO;
import com.GolfStore.backend.model.Product;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

/*
    - Denne klassen inneholder metoder som brukes til å bygge en spørring.
    - Hver metode legger til et ekstre kriterie til spørringen HVIS den blir kalt
        - For eksempel: Hvis man huker av et spesefikt brand i frontend blir hasAnyBrand metoden aktivert.

    - Hele flyten: En bruker velger Tshirt som kategori av produkter, deretter huker man av brand Adidas og Nike
    - De velger ingen ytterligere kriterier.
    - I frontend blir det da dynamisk generert query parametere i endpointet.
        - For eksempel: http://localhost:8080/products/MenuGrid?category=Tshirt&Brand=Adidas&Brand=Nike
            - "?category=Tshirt&Brand=Adidas&Brand=Nike" er parameterne som blir generert.
    - ProductController mottar da disse parameterne i endpointet, og mapper disse inn i en DTO som heter ProductSearchCriteriaDTO.
    - ProductSearchCriteriaDTO er et objekt som inneholder alle kriteriene som er mulig for produktene og ser slik ut:
    -   private String category;
        private List<String> brand;
        private List<String> size;
        private List<String> color;
        private Double minPrice;
        private Double maxPrice;
    - Når endpointet har mottatt forespørselen med parameterne, trekker controlleren ut parameterne, og sender det videre til en metode iProductService kalt getProductsForMenuGrid.
    - getProductsForMenuGrid bruker da en metode fra ProductSpecification(denne klassen) kalt ProductCriteriaBuilder, til å lage en custom query basert på productSearchCriteriaDTO.
    - ProductCriteriaBuilder bygger da altså spørringen som skal brukes til å finne produktene som har de kriteriene man ønsker.
        - ProductCriteriaBuilder er også en nullsjekker på en måte. Den tar imot productSearchCriteriaDTO, og ser hvilken av attributtene som har en verdi.
            - Hvis et attributt har en verdi, kjøres en egen metode(se under feks: hasCategory, hasPriceBetween) for det attributtet, som inneholder tabellnavnet og søkenøkkelen. Disse egne metodene er byggeklossene til spørringen
                - For eksempel. Hvis attributtet cateogry har en verdi, la oss si "category": "Tshirt". Da legges det til en WHERE clause i spørringen, med WHERE category.categoryName = 'Tshirt'
       - Hvis attributtet har null verdi, skippes dette, og den legger ikke til en WHERE clause.
    - Kort forklart. ProductCriteria builder bruker "has" metodene til å dynamisk bygge en spørring, basert på hva slags verdier den får fra productSearcCriteriaDTO.


 */

public class ProductSpecification {

    //Specification methods
    public static Specification<Product> hasCategory(String category) {
        return (root, query, cb) ->
                category != null ? cb.equal(root.get("category").get("categoryName"), category) : null;
    }

    public static Specification<Product> hasAnyBrand(List<String> brandNames) {
        return (root, query, cb) -> {
            if (brandNames == null || brandNames.isEmpty()) {
                return null;
            }
            return root.get("brand").get("brandName").in(brandNames);
        };
    }

    public static Specification<Product> hasPriceBetween(Double minPrice, Double maxPrice) {
        return (root, query, cb) -> {
            //Hvis minprice og maxprice begge ikke er null, legges det til cb.between minprice og maxprice.
            //altså, WHERE price BETWEEN 100 and 200 feks.
            if (minPrice != null && maxPrice != null) {
                return cb.between(root.get("price"), minPrice, maxPrice);
            } else if (minPrice != null) {
                return cb.greaterThanOrEqualTo(root.get("price"), minPrice);
            } else if (maxPrice != null) {
                return cb.lessThanOrEqualTo(root.get("price"), maxPrice);
            } else {
                return null;
            }
        };
    }

    public static Specification<Product> hasVariantAttribute(String attributeType, List<String> values) {
        return (root, query, cb) -> {
            if (values == null || values.isEmpty() || attributeType == null) {
                return null;
            }
            // Joiner Product med ProductVariant
            Join<Object, Object> variant = root.join("productVariants", JoinType.INNER);
            // Joiner ProductVariant med VariantAttribute
            Join<Object, Object> attribute = variant.join("attributes", JoinType.INNER);
            // Joiner VariantAttribute med FilterOption
            Join<Object, Object> option = attribute.join("filterOption", JoinType.INNER);
            // Joiner VariantAttribute med FilterValue
            Join<Object, Object> value = attribute.join("filterValue", JoinType.INNER);


            /* Lager en condition: attributeType = 'Size' or 'Color'
            filterName er i databasen feks Size, Color, Price etc. attributeType er det man har skrevet inn
            som man ønsker å finne. Så hvis man for eksempel skal filtrere etter en t-skjorte etter størrelse small
            blir dette da WHERE filtername = Size. Kombinert med ValueMatch, blir dette da WHERE filterName = size
             AND filterValue = small.
            Values kan være list, så man kan huke av flere ting, så da blir det noe som Where filtername = size AND
            filtervalue = small OR filtervlaue=Large.
            Så hele poenget er da altså at den finner varianter, hvor produktet har en kombinasjon av attributtene
            (via andre tabeller) Size og ønsket størrelse. kombinasjonen av filteroption SIZE og filtervalue small feks.

            Den henter da alle produkter som har filteroption Size, også filtrerer den ut ifra de etter størrelsen.
             */
            Predicate typeMatch = cb.equal(option.get("filterName"), attributeType);


            Predicate valueMatch = value.get("filterValue").in(values);

            /* Her sendes tilbake den fullførte WHERE condition. Dette kan oversettes til feks:
            * WHERE filter_option.filter_name = 'Size'
  AND fil     AND filter_value.filter_value IN ('Small', 'Medium') */
            return cb.and(typeMatch, valueMatch);
        };
    }


    //Specification builder/Criteria builder
    public static Specification<Product> ProductCriteriaBuilder(ProductSearchCriteriaDTO criteria) {

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
        return spec;

    }
}


