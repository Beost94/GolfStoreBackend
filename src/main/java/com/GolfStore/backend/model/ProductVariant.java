package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Entity
@Data
@Table(name = "product_variants")
public class ProductVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "variantid")
    private Integer variantId;

    @ManyToOne
    @JoinColumn(name = "productid")
    private Product product; //

    @OneToMany(mappedBy = "productVariant", cascade = CascadeType.ALL)
    private List<VariantAttribute> attributes; //
}



