package com.GolfStore.backend.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;


@Entity
@Table(name= "flex")
@Getter
@Setter
@NoArgsConstructor
public class Flex {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int flexid;
    private String flexname;

    /*Sier denne tabellen, har et mange til mange forhold med en annen tabell
     @ManyToMany og @JoinTable er knyttet til private Set<Loft> lofts. Akkurat som @id og @generatedValue
    er knyttet til private long flexid */
    @ManyToMany
    @JoinTable(
            name = "flexloft",

            //Denne sier: flexid i koblingstabellen er flexid fra denne tabellen ( Flex )
            //Dette blir fremmednøkkelen fra denne tabellen som vi er i nå, som er Flex.
            joinColumns = @JoinColumn(name="flexid"),
            //Denne sier: loftid i koblingstabellen er loftid i den andre tabellen ( Loft)
            //Dette blir da fremmednøkkelen fra den andre taballen, som er Loft
            inverseJoinColumns = @JoinColumn(name = "loftid")
    )
    //Det er her, jpa vet hvor den skal hente loftid fra.
    //Dette lager på en måte et attributt for denne tabellen, som viser hvilke loft, denne flexen kan ha.
    //Da kan man bare hente de loftsene fra dette attributtet istedenfor koblingstabellen. PÅ EN MÅTE.
    private Set<Loft> lofts = new HashSet<>();

    @ManyToMany(mappedBy = "flex")
    private Set<GolfClubs> golfClubs = new HashSet<>();

}
