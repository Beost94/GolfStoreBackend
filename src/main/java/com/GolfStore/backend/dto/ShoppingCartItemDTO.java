package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor

@Data

public class ShoppingCartItemDTO {

    private Integer productId;
    private Integer variantId;
    private String productName;
    private Double price;
}
