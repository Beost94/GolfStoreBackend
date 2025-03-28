package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "shoppingcartitems")
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
