package com.GolfStore.backend.repository;

import com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO;
import com.GolfStore.backend.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {
    Page<Product> findByCategory_CategoryName(String category, Pageable pageable);


    @Query("""
    SELECT new com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO(
        p.productId, v.variantId, fo.filterName, fv.filtervalueName, fo.isMainAttribute
    )
    FROM Product p
    JOIN p.brand b
    LEFT JOIN p.images i
    JOIN p.productVariants v
    JOIN v.variantAttributes va
    JOIN va.filterOption fo
    JOIN va.filterValue fv
    WHERE p.productId = :productId
""")
    List<FlatVariantsDTO> findVariantsByProductId(@Param("productId") Integer productId);

}
