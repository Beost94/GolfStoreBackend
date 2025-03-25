package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "category_filter_options")
public class CategoryFilterOption { // ✅ Singular class name

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_filter_optionsid") // ✅ Explicit column name (optional, for clarity)
    private int categoryFilterOptionId;

    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    private Category category;

    @ManyToOne
    @JoinColumn(name = "filter_optionid", nullable = false)
    private FilterOption filterOption; // ✅ Singular entity class name
}
