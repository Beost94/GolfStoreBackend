package com.GolfStore.backend.repository;

import com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO;
import com.GolfStore.backend.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {

    /*
            -Custom query that grabs all the variant attribute data for a given product,
            - flattening it out into a list of FlatVariantsDTOs.

            - this is useful because instead of loading the full product + variant + attributes graph and mapping manually,
            - we just pull the exact fields needed in a single optimized join heavy query.

            - This is used to build the ProductWithVariantsDTO on the service layer.
     */

    @Query("""
    SELECT new com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO(
        p.productId, v.variantId, fo.filterName, fv.filtervalueName, fo.isMainAttribute
    )
    FROM Product p
    JOIN p.brand b
    JOIN p.productVariants v
    JOIN v.variantAttributes va
    JOIN va.filterOption fo
    JOIN va.filterValue fv
    WHERE p.productId = :productId
""")
    List<FlatVariantsDTO> findVariantsByProductId(@Param("productId") Integer productId);

}



