package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.GolfClubs;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GolfClubsRepository extends JpaRepository<GolfClubs, Integer> {

    /*findByGccategory_Gccategoryname er ikke bare et valgfritt navn man gir dette attributtet. Dette er en måte å lage
    * en custom query med jpa. findBy er et nøkkelord.
    * SpringJpa repository er en interface som kommer med mange metoder for queries mot database. findBy er en måte å lage
    * en custom query på . Det den gjør er basically er å legge til en WHERE. SELECT * FROM golfclubs WHERE !!name=parameter"!!
    * I entiteten vi skal gjøre denne spørringen mot, har man 2 attributter. Productid, og GolfClubCategory. GolfClubCategory attributtet
    * er en referanse til en forekomst av en annen entitet, GolfClubsCategory. Vi vil bruke gccategoryname til å hente kun ønsket kategory
    * av golfkøller. gccategoryname er i entiteten GolfClubsCategory, som er mappet inn i GolfClubs.
    * Derfor heter denne "metoden" det den gjør. findBy "Gccategory" altså det attributtet som er en entitet. Understrek
    * betyr inni dette objektet, finn dette: Gccategoryname. Det blir da find by Gccategory sin Gccategoryname.
    * Kort forklart. Den finner golfkøller som har gccategoryname = det man ønsker.   */
    Page<GolfClubs> findAll(Pageable pageable);

    Page<GolfClubs> findByGccategory_Gccategoryname(Pageable pageable, String gccategoryname);

}


