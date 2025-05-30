package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "shoppingcartitems")
@AllArgsConstructor
@NoArgsConstructor

public class ShoppingCartItem {

    @EmbeddedId
    private ShoppingCartItemKey id;

    @ManyToOne
    @MapsId("shoppingCartId")  // Maps to field in ShoppingCartItemKey


    @JoinColumn(name = "shoppingcartid")
    private ShoppingCart shoppingCart;

    @ManyToOne
    @MapsId("productVariantId")
    @JoinColumn(name = "variantid")
    private ProductVariant productVariant;

    @Column(name = "amount")
    private Integer amount;
}
