package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
@AllArgsConstructor
@Data

public class ShoppingCartDTO {

    private Integer shoppingcartId;
    private List<ShoppingCartItemDTO> shoppingcartItems;

}
