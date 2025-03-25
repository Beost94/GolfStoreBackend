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
    private Integer variantAttributeId; //

    @ManyToOne
    @JoinColumn(name = "variantid")
    private ProductVariant productVariant; //

    @ManyToOne
    @JoinColumn(name = "filter_optionid")
    private FilterOption filterOption; //

    @ManyToOne
    @JoinColumn(name = "filter_valueid")
    private FilterValue filterValue;
}
