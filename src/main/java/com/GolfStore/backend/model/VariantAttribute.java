package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "variant_attributes")
public class VariantAttribute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "variant_attributeid")
    private Integer variantAttributeId; // ✅ Capital "I" for consistency

    @ManyToOne
    @JoinColumn(name = "variantid")
    private ProductVariant productVariant; // ✅ Singular class name

    @ManyToOne
    @JoinColumn(name = "filter_optionid")
    private FilterOption filterOption; // ✅ Singular class name

    @ManyToOne
    @JoinColumn(name = "filter_valueid")
    private FilterValue filterValue;
}
