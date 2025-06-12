package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "shoppingcartitems")

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter

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
