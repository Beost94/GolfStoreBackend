package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "products")
@Getter @Setter // Lombok automatically generates getters & setters
@NoArgsConstructor // Lombok creates a default constructor
public class Products {

    @Id /* Dette setter at productid er primærnøkkelen i tabellen.  */
    @GeneratedValue(strategy = GenerationType.IDENTITY) /* Dette forteller om hvordan primærnøkkelen blir generert,
    altså den blir auto-generert */
    private int productid;

    private String productname;
    private Double price;
    private String description;


    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    private ProductCategory categoryid;
}
