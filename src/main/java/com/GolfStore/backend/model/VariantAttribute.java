package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "variant_attributes",
//Made some indexes for these, since they will be used with a couple join heavy queries
indexes = {
        @Index (name = "idx_variant_attributes_variantid", columnList = "variantid"),
        @Index (name = "idx_variant_attributes_filter_optionid", columnList = "filter_optionid"),
        @Index (name = "idx_variant_attributes_filter_valueid", columnList = "filter_valueid")
})
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

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
