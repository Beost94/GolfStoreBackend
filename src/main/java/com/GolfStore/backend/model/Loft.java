package com.GolfStore.backend.model;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "loft")
@Getter @Setter // Lombok automatically generates getters & setters
@NoArgsConstructor
public class Loft {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int loftid;
    private String loftname;

    @ManyToMany(mappedBy = "lofts")
    private Set<Flex> flexes = new HashSet<>();
}
