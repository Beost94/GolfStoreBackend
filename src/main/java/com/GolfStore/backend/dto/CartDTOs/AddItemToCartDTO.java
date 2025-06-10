package com.GolfStore.backend.dto.CartDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class AddItemToCartDTO {
    private Integer variantId;
    private Integer amount;

}



