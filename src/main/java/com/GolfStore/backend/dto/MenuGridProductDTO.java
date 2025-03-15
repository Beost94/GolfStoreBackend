package com.GolfStore.backend.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MenuGridProductDTO {
    private Integer productId;
    private String productName;
    private BigDecimal price;
    private String brandName;
    private String imageUrl; // Kun ett bilde for visning
}
