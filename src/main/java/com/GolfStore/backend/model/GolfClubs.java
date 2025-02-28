    package com.GolfStore.backend.model;

    import jakarta.persistence.*;
    import lombok.Getter;
    import lombok.Setter;

    import java.util.HashSet;
    import java.util.Set;

    @Entity
    @Getter
    @Setter
    @Table(name = "golfclubs")
    public class GolfClubs {

        @Id
        @Column(name = "productid")
        private int productid;

        @OneToOne
        // @mapsid forteller at denne entiteten, skal bruke primærnøkkelen til en annen entitet.
        @MapsId
        @JoinColumn(name = "productid")
        private Products product;


        @ManyToOne
        @JoinColumn(name = "gccategoryid", nullable = false)
        private GolfClubsCategory gccategory;


        @ManyToMany
        /* Siden av relasjonen som har denne delen: JoinTable, er den som "eier" relasjonen
        siden som har mappedBy, er den andre siden. @JoinTable er knyttet til
         Set<Flex> flex*/
        @JoinTable(
                name = "flexgolfclub",

                joinColumns = @JoinColumn(name = "productid"),
                inverseJoinColumns = @JoinColumn(name = "flexid")
        )
        private Set<Flex> flex = new HashSet<>();

    }
