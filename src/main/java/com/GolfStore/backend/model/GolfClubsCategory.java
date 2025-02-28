package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "golfclubscategory")
@Getter
@Setter
@NoArgsConstructor
public class GolfClubsCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int gccategoryid;
    private String gccategoryname;

    /* Dette er andre siden av @ManyToOne fra GolfClubs klassen.
       mappedBy sier hvilke attributt på den andre siden av
       relasjonen(andre tabellen) som er kilden til relasjonen*/
    @OneToMany(mappedBy = "gccategory", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<GolfClubs> golfClubs = new HashSet<>();


}



