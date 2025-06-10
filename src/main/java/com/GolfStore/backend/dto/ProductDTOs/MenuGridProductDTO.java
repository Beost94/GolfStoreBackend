package com.GolfStore.backend.dto.ProductDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MenuGridProductDTO {
    private Integer productId;
    private String productName;
    private Double price;
    private String brandName;
    private String imageUrl; // Kun ett bilde for visning
}
