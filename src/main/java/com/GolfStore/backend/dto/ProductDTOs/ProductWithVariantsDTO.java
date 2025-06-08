package com.GolfStore.backend.dto.ProductDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductWithVariantsDTO {

    private Integer productId;
    private String productName;
    private Double price;
    private String description;
    private List<String> imageUrls; // Alle bilder av produktet
    private List<ProductVariantDTO> variants;

}
