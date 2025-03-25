package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "productstock")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductStock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stockid")
    private Integer stockId;

    @ManyToOne
    @JoinColumn(name = "productid", nullable = false)
    private Product product;

    @ManyToOne
    @JoinColumn(name = "variantid")
    private ProductVariant variant;

    @Column(name = "stockcount", nullable = false)
    private Integer stockCount;
}
