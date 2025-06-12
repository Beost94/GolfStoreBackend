package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

//Tried some indexing to test this out, trying to optimize join heavy queries
@Entity
@Table(name = "products",
indexes = {
        @Index(name = "idx_products_categoryid", columnList = "categoryid"),
        @Index(name = "idx_products_brandid", columnList ="brandid")
})
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productid")
    private Integer productId;

    @Column(name = "productname", nullable = false)
    private String productName;

    @Column(name = "price", nullable = false)
    private Double price;

    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    private Category category;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "brandid")
    private Brand brand;

    @Column(name = "has_variants")
    private Boolean hasVariants;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Images> images;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductVariant> productVariants;
}
