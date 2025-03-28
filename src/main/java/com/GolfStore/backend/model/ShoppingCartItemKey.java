package com.GolfStore.backend.model;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class ShoppingCartItemKey implements Serializable {
    private Integer shoppingCartId;
    private Integer productVariantId;
}
