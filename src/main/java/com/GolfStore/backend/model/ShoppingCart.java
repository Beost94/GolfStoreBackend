package com.GolfStore.backend.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "shoppingcart")
public class ShoppingCart {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column( name = "shoppingcartid")
    private int shoppingCartId;

    @OneToOne
    @JoinColumn(name = "keycloakid", referencedColumnName = "keycloakid")
    private User user;

    @OneToMany(mappedBy = "shoppingCart", cascade = CascadeType.ALL)
    private List<ShoppingCartItem> items;
}
