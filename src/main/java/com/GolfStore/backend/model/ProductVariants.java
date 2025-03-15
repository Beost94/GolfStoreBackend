package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "productvariants")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariants {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "variantid")
    private Integer variantId;

    @Column(name = "variantname")
    private String variantName;
}
