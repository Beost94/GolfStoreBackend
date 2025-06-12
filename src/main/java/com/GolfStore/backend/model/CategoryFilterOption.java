package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "category_filter_options")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class CategoryFilterOption { //

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_filter_optionsid") //
    private int categoryFilterOptionId;

    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    private Category category;

    @ManyToOne
    @JoinColumn(name = "filter_optionid", nullable = false)
    private FilterOption filterOption; //
}
