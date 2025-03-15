package com.GolfStore.backend.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailDTO {
    private Integer productId;
    private String productName;
    private BigDecimal price;
    private String description;
    private String brandName;
    private String categoryName;
    private Boolean hasVariants;
    private List<String> imageUrls; // Alle bilder av produktet
}
