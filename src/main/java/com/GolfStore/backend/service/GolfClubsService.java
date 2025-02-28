package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.GolfClubsDTO;
import com.GolfStore.backend.model.GolfClubs;
import com.GolfStore.backend.repository.GolfClubsRepository;
import com.GolfStore.backend.dto.PageResponseDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GolfClubsService {

    private final GolfClubsRepository golfClubsRepository;

    public GolfClubsService(GolfClubsRepository golfClubsRepository) {
        this.golfClubsRepository = golfClubsRepository;
    }


    public PageResponseDTO<GolfClubsDTO> getAllGolfClubs(int page, int size) {
        /*Pageable er en interface. PageRequest er en class, som implementerer Pageable.  Her lager man en
         variabel av typen Pageable, som "holder" et PageRequest objekt.
         PageRequest har noen metoder som blant annet getPage og getSize.
         Når man metoden getAllGolfClubs blir kalt med parameterne page og size. instansieres først Pageable variabelen
         Også kjøres findAll metoden fra spring repository interfacen, med pageable som parameter.
         Pageable holder altså verdier for hvilken side man skal laste, og hvor stor sidene skal være.
         La oss si man har menugrid, og man skal vise 20 items per side. Det er 10 sider med produkter. Når man
         sender en forespørsel til endpoint, som vil et sted i kjeden kjøre getAllGolfClubs, vil den sende hvilken side
         man er på, og hvilke produkter man skal hente. La oss si man blar til side 2. Da da "hopper den over" de 20
         første produktene i databasen, og henter kun de 20 neste. Kort forklart. pageable forteller findall metoden,
         hvilke produkter den skal hente ifølge hvilken side man er på, og hvor mange en side skal vise.
        */
        Pageable pageable = PageRequest.of(page, size);
        /*
        Page <GolfClubs> golfClubsPage = golfClubsRepository.findAll(pageable).
        Page<T> er en generic interface. her lager man en instanse av den interfacen, kaller den golfClubsPage.
        Det denne instansen gjør er at den tar imot all Rå data fra entitetene(db), lagrer denne og lagrer data om
        hvor mange sider, elementer, osv osv.

        findAll(pageable). Når denne kjører, så gjør Spring jpa noe i bakgrunnen. Den gjør en COUNT(*) query,
        og teller opp alle radene fra tabellen den finder all på. Den gjør dette til pages. Så hvis det er 100 rader,
        og 10 items per rad, så blir det 10 sider. Hvis man skal hente side 2 feks,
        kjøres dette: SELECT * FROM golfclubs ORDER By id, LIMIT 10 OFFSET 20;. Start på 10, slutt på 20, gjør disse om til DTO
        og send videre.

         */
        Page<GolfClubs> golfClubsPage = golfClubsRepository.findAll(pageable);

        /* objektet golfClubsPage av klassen Page har hentet kun 1 side med golfkøller, la oss si 10, rett over^. golfClubsPage inneholder da nå metadata om
        hele tabellen, altså antall rader, antall elementer osv. Den har også et attrbiutt i form av en liste, som holder rådata om objektene den hentet.
        Som man ser under. i de neste linjene, brukes metoden .getContent() på golfClubsPage. Det er en metode for å hente rådataen fra databasen, som liste attributtet
        i golfClubsPage holder. Denne dataen blir da mappet gjennom, og hvert rå objekt blir da omgjort til en golfClubDTO, og samlet i en liste. Denne listen heter da
        dtos.
        Etter dette, så returneres dette i form av et PageResponseDTO, som inneholder golfClubsPage(Rådata og metadata) og dtos(10 stk golfclubsDTO);


         */
        List<GolfClubsDTO> dtos = golfClubsPage.getContent().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());

        /*Når Her "instansierer" man et objekt av pageresponse. Sender over golfclubsPage som inneholder rådata fra entitetene,
        * metadata om hvilken page, antall pages, antall elementer, altså metadata og dto's*/
        return PageResponseDTO.of(golfClubsPage, dtos);
    }


    public PageResponseDTO<GolfClubsDTO> getGolfClubsByCategory(String gccategoryname, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<GolfClubs> golfClubsPage = golfClubsRepository.findByGccategory_Gccategoryname(pageable, gccategoryname);

        List<GolfClubsDTO> dtos = golfClubsPage.getContent().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());

        return PageResponseDTO.of(golfClubsPage, dtos);
    }

    private GolfClubsDTO convertToDTO(GolfClubs golfClub) {
        return new GolfClubsDTO(
                golfClub.getProductid(),
                golfClub.getProduct().getProductname(),
                golfClub.getProduct().getPrice(),
                golfClub.getProduct().getDescription(),
                golfClub.getGccategory().getGccategoryname()
        );
    }
}
