package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.ProductStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StockRepository extends JpaRepository<ProductStock, Integer> {

    @Query("SELECT ps.stockCount FROM ProductStock ps WHERE ps.variant.variantId = :variantId")
    Integer findStockCountByVariantId(@Param("variantId") Integer variantId);
}
