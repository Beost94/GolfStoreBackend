package com.GolfStore.backend.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;



@Entity
@Table(name = "shoppingcart")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

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
