package com.GolfStore.backend.model;


import jakarta.persistence.*;

@Entity
@Table(name = "filter_values")

public class FilterValue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "filter_valueid")
    private Integer filterValueId;

    @ManyToOne
    @JoinColumn(name = "filter_optionid")
    private FilterOption filterOption;

    @Column(name = "filter_value")
    private String filterValue;

}
