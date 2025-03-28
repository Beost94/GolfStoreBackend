package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.UserDTO;
import com.GolfStore.backend.model.ShoppingCart;
import com.GolfStore.backend.model.User;
import com.GolfStore.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;


   /*
    This method is for getting userdata in the form of a userDTO AND posting the users data to the database, if its the first time they visit this endpoint.
    A lot of userdata is stored in keyCloak, this is where they register their user. We still need that data easily accessible, without getting it from keyCloak all the time, so we need it stored in the database.
    The method takes a jwt. IT extracts the keyCloakid(Which is what we use as a PK for the user table) from the JWT. It then Checks the database to see if this keycloakid is present. If it is takes that instance
    of the entity, and converts it to a DTO and returns it to the endpoint. If it doesnt find an instance in the database with this keycloakid, it runs a method called createUserFromjwt. This method extracts
    all the userdata we want from the JWT and makes a new user object with this data. it then posts this newly made user object to the database, at the same time it takes this newly made user and returns it as a DTO,
    as it does with users that are already registered. *If the user doesnt exist, register it to the database and send a DTO of it*  In both cases, we always return a DTO representation of the user.
   */
    public UserDTO getOrCreateUser(Jwt jwt) {
        UUID keyCloakId = UUID.fromString(jwt.getSubject());

        /*Repositories returnerer alltid Optional<T>.. Det som skjer her med .orElseGet() er litt missvisende i navnet spør du meg.
        .orElse er en metode for Optional klassen. Optional klassen er en slags failsafe for å ikke returnere null. Den kan holde på alle typer
        objekter. i dette tilfellet User, Optional<User>. Optional betyr altså egentlig at enten har den noe, eller så har den ikke noe, men ikke null
        .orElse() sjekker om optional objektet har en verdi, og hvis den har det, tar den ut den verdien og returnerer den, for eksempel et objekt av klassen  User. Hvis det ikke er noe verdi,
        kan man designere en default verdi. orElse(xxxx) -- Hvis den ikke har en verdi, bruk denne verdien
        .orElseGet() Så kan man legge til en funksjon som generer en verdi til å returnere, hvis optional objektet ikke holder på noen verdi. Det funker på samme måte som .orElse, bare at default verdien
        er generert av en funksjon.

        Sååå.... Det som skjer her er da: userRepository kjører findByID metoden, med keyCloakid(det er primærnøkkelen for users). Dette returnerer et Optional<User> objekt. Dette Optional objektet holder da på et User
        objekt, hvis det fant en user som passer. Hvis den ikke fant noe, holder den ikke på noe. Så kommer .orElseget(). Denne delen henter ut verdien fra Optional<User>. Hvis det er noe i den. Designerer den da
        User user = user objektet. Hvis den ikke fant noe, så bruker den en default verdi, som er generert med lambda funksjonen. Denne funksjonen lager et nytt objekt av User, med å bruke createUserFromJwt metoden.
        return userRepository.save(newUser); Lagrer brukeren til databsen, samtidig som den returnerer det til orElseGet.

           */
        User user = userRepository.findById(keyCloakId).orElseGet(() -> {
            User newUser = createUserFromJwt(jwt);
            return userRepository.save(newUser);
        });
        return convertToDTO(user);
    }

    public UserDTO convertToDTO(User user) {
        return new UserDTO(
                user.getKeycloakId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getAdress(),
                user.getPhone()
        );
    }

    public User createUserFromJwt(Jwt jwt) {
        User newUser = new User();
        newUser.setKeycloakId(UUID.fromString(jwt.getSubject()));
        newUser.setEmail(jwt.getClaim("email"));
        newUser.setFirstName(jwt.getClaim("given_name"));
        newUser.setLastName(jwt.getClaim("family_name"));
        newUser.setAdress(jwt.getClaim("adress"));

        ShoppingCart cart = new ShoppingCart();
        cart.setUser(newUser);
        newUser.setShoppingCart(cart);

        return newUser;

    }
}
