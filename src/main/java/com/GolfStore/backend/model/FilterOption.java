package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
@Table(name = "filter_options")
public class FilterOption { // ✅ Singular name (one row = one FilterOption)

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "filter_optionid")
    private Integer filterOptionId;

    @Column(name = "filter_name")
    private String filterName;

    @OneToMany(mappedBy = "filterOption") // ✅ Matches field name in FilterValue entity
    private List<FilterValue> filterValues;
}

