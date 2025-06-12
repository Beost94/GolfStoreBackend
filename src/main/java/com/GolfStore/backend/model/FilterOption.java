package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "filter_options")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class FilterOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "filter_optionid")
    private Integer filterOptionId;

    @Column(name = "filter_name")
    private String filterName;

    @OneToMany(mappedBy = "filterOption")
    private List<FilterValue> filterValues;

    @Column(name="is_main_attribute")
    private boolean isMainAttribute;
}

