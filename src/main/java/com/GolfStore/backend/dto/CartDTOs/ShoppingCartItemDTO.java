package com.GolfStore.backend.dto.CartDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ShoppingCartItemDTO {

    private Integer productId;
    private Integer variantId;
    private String productName;
    private Double price;
    private Integer amount;
    private String imageUrl;

}
