package com.GolfStore.backend.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "filter_values")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter

public class FilterValue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "filter_valueid")
    private Integer filterValueId;

    @ManyToOne
    @JoinColumn(name = "filter_optionid")
    private FilterOption filterOption;

    @Column(name = "filter_value")
    private String filtervalueName;

}
