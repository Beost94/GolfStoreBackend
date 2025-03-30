package com.GolfStore.backend.specifications;


import com.GolfStore.backend.model.Product;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;


/*Denne klassen er egentlig bare for å definere metoder for å bygge sql spørringer. Man kaller disse metodene
* etter behov for hva man trenger å legge til i sql spørringen.  */
public class ProductSpecification {

    /*Hver metode her er en "filter generator". De lager WHERE conditions til spørringen.
    Ser på hasCategory. Denne delen lager WHERE categoryName = x.  Man bygger spørringen med disse.
     Denne returnerer altså bare mer eller mindre WHERE. Altså hvis man får en get forespørsel
     som inneholder category parameter, kjøres denne metoden og den legger til WHERE categoryName = x
     i spørringen som blir gjort mot databasen. */

    /* root.get("category").get(categoryname"), category
     * Dette blir da finn categoryname attributtet i category tabellen, og er lik category. category er
     * parameteren som blir overført hit, det kan feks være golfkølle.*/
    public static Specification<Product> hasCategory(String category) {
        return (root, query, cb) ->
                category != null ? cb.equal(root.get("category").get("categoryName"), category) : null;
    }

    public static Specification<Product> hasBrand(String brandName) {
        return (root, query, cb) ->
                brandName != null ? cb.equal(root.get("brand").get("brandName"), brandName) : null;

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



}


