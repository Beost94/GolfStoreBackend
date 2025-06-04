package com.GolfStore.backend.SpringSecurityConfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Collection;
import java.util.Map;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // Disable CSRF for REST APIs
                .csrf(csrf -> csrf.disable())

                // Enable CORS
                .cors(cors -> {})

                // Use stateless session management (no cookies, use JWT tokens)
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                // URL-based security rules
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/hello").permitAll() // ✅ MOVE THIS UP
                        .requestMatchers("/products/**", "/", "/index.html", "/error").permitAll()
                        .requestMatchers("/user/**").hasRole("USER")
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .requestMatchers("/ShoppingCart/**").hasRole("USER")
                        .anyRequest().authenticated() // ⛔ Catch-all at the end
                )



                // Configure JWT authentication
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwt -> jwt
                                .jwtAuthenticationConverter(jwtAuthenticationConverter())
                        )
                );

        return http.build();
    }


    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(new KeycloakRoleConverter());
        return converter;
    }

    /**
     * Converter class for extracting Keycloak roles from a JWT token and converting them
     * to Spring Security GrantedAuthority objects.
     *
     * This converter handles both realm roles and client-specific roles from Keycloak,
     * prefixing them with "ROLE_" to match Spring Security's role-based authorization model.
     */
    static class KeycloakRoleConverter implements Converter<Jwt, Collection<GrantedAuthority>> {
        private final JwtGrantedAuthoritiesConverter defaultConverter = new JwtGrantedAuthoritiesConverter();
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(KeycloakRoleConverter.class);

        /**
         * Converts JWT claims to a collection of GrantedAuthority objects.
         * Extracts roles from both realm_access and resource_access claims in the Keycloak JWT.
         *
         * @param jwt The JWT token to extract authorities from
         * @return A collection of GrantedAuthority objects representing the user's roles
         */
        @Override
        public Collection<GrantedAuthority> convert(Jwt jwt) {
            // Get default authorities using the standard converter
            Collection<GrantedAuthority> authorities = defaultConverter.convert(jwt);

            // Log JWT claims and default authorities for debugging
            log.debug("JWT claims: {}", jwt.getClaims());
            log.debug("Default authorities: {}", authorities);
            System.out.println("JWT claims: " + jwt.getClaims());
            System.out.println("Default authorities: " + authorities);

            // Extract realm roles from the JWT token's realm_access claim
            Map<String, Object> realmAccess = jwt.getClaimAsMap("realm_access");
            if (realmAccess != null && realmAccess.containsKey("roles")) {
                @SuppressWarnings("unchecked")
                Collection<String> roles = (Collection<String>) realmAccess.get("roles");
                log.debug("Realm roles: {}", roles);
                roles.forEach(role -> {
                    // Convert each role to an authority with the "ROLE_" prefix
                    SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_" + role.toUpperCase());
                    log.debug("Adding realm authority: {}", authority);
                    authorities.add(authority);
                });
            } else {
                log.debug("No realm_access roles found");
            }

            // Extract client-specific roles from the JWT token's resource_access claim
            Map<String, Object> resourceAccess = jwt.getClaimAsMap("resource_access");
            if (resourceAccess != null) {
                log.debug("Resource access: {}", resourceAccess);
                resourceAccess.forEach((clientId, clientAccess) -> {
                    if (clientAccess instanceof Map) {
                        Map<String, Object> clientAccessMap = (Map<String, Object>) clientAccess;
                        if (clientAccessMap.containsKey("roles")) {
                            @SuppressWarnings("unchecked")
                            Collection<String> roles = (Collection<String>) clientAccessMap.get("roles");
                            log.debug("Client '{}' roles: {}", clientId, roles);
                            roles.forEach(role -> {
                                // Convert each client role to an authority with the "ROLE_" prefix
                                SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_" + role.toUpperCase());
                                log.debug("Adding client authority: {}", authority);
                                authorities.add(authority);
                            });
                        }
                    }
                });
            } else {
                log.debug("No resource_access roles found");
            }

            // Log the final set of authorities for debugging
            log.debug("Final authorities: {}", authorities);
            return authorities;
        }
    }
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedOriginPattern("*");  // Accept any origin
        config.addAllowedHeader("*");         // Accept any header
        config.addAllowedMethod("*");         // Accept GET, POST, etc.
        config.setAllowCredentials(true);     // Optional, allow cookies if needed

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }


}
