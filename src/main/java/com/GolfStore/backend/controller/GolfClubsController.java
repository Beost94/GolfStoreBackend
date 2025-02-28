package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.GolfClubsDTO;
import com.GolfStore.backend.dto.PageResponseDTO;
import com.GolfStore.backend.service.GolfClubsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/golfclubs")
public class GolfClubsController {

    private final GolfClubsService golfClubsService;

    public GolfClubsController(GolfClubsService golfClubsService){
        this.golfClubsService = golfClubsService;
    }

    /*
    Det er hos controlleren alt starter. Det er her kjedereaksjonen mellom alle lagene skjer.
    En forespørsel blir sendt til endepunktet api/golfclubs med noen parametere. Dette plukker @GetMapping opp.
    Hvis det er parametere som feks category, eller page etc, plukker @Requestparam disse opp.

    Etter dette, kjøres en metode eller en annen, basert på om det er kategori i url'en eller ikke. La oss si det er det.
    Da kjøres getGolfClubsByCategory, og parameterne gccategoryname, page og size blir overført til den metoden.
    Denne metoden ligger i GolfClubsService.

    */
    @GetMapping
    public PageResponseDTO<GolfClubsDTO> getGolfClubs(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String gccategoryname
    ) {
        if (gccategoryname != null) {
            return golfClubsService.getGolfClubsByCategory(gccategoryname,page,size);
        }
        return golfClubsService.getAllGolfClubs(page,size);
    }
}
