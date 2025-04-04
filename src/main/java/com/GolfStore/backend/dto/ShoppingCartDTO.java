package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;

import java.util.List;
@AllArgsConstructor
public class ShoppingCartDTO {

    private Integer shoppingcartId;
    private List<ShoppingCartItemDTO> shoppingcartItems;

}
