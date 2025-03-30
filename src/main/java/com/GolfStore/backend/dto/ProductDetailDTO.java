package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailDTO {
    private Integer productId;
    private String productName;
    private Double price;
    private String description;
    private String brandName;
    private String categoryName;
    private Boolean hasVariants;
    private List<String> imageUrls; // Alle bilder av produktet
}
