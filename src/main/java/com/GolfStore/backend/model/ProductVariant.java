package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "product_variants")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

public class ProductVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "variantid")
    private Integer variantId;

    @ManyToOne
    @JoinColumn(name = "productid")
    private Product product; //

    @OneToMany(mappedBy = "productVariant", cascade = CascadeType.ALL)
    private List<VariantAttribute> variantAttributes; //
}



