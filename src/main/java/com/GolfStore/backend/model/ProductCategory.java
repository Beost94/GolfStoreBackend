package com.GolfStore.backend.model;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "productcategories")
@Getter
@Setter
@NoArgsConstructor


public class ProductCategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int categoryid;
    private String categoryname;


    @OneToMany(mappedBy = "categoryid", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Products> products = new HashSet<>();
}
