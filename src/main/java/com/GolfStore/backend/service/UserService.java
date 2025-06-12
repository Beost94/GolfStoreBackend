package com.GolfStore.backend.service;

import com.GolfStore.backend.DTOMapper.DTOMapper;
import com.GolfStore.backend.dto.UserDTOs.UserDTO;
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
    private final DTOMapper dtoMapper;

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
        User user = userRepository.findById(keyCloakId).orElseGet(() -> {
            User newUser = createUserFromJwt(jwt);
            return userRepository.save(newUser);
        });
        return dtoMapper.mapToUserDTO(user);
    }


    public User createUserFromJwt(Jwt jwt) {
        User newUser = new User();
        newUser.setKeycloakId(UUID.fromString(jwt.getSubject()));
        newUser.setEmail(jwt.getClaim("email"));
        newUser.setFirstName(jwt.getClaim("given_name"));
        newUser.setLastName(jwt.getClaim("family_name"));
        newUser.setAddress(jwt.getClaim("adress"));

        ShoppingCart cart = new ShoppingCart();
        cart.setUser(newUser);
        newUser.setShoppingCart(cart);

        return newUser;

    }
}
