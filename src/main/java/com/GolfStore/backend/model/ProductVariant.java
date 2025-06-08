package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@Table(name = "product_variants")
@AllArgsConstructor
@NoArgsConstructor
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



