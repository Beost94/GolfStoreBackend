    package com.GolfStore.backend.model;

    import jakarta.persistence.*;
    import lombok.*;

    @Entity
    @Table(name = "brand")
    @NoArgsConstructor
    @AllArgsConstructor
    @Getter
    @Setter

    public class Brand {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "brandid")
        private Integer brandId;

        @Column(name = "brand_name", length = 50)
        private String brandName;
    }
