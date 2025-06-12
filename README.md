# GolfStore Backend

This is the backend for the GolfStore web application, built with Spring Boot and PostgreSQL. It provides RESTful APIs for managing products, shopping carts, and user accounts. Authentication and authorization are handled using Keycloak.

---

## ⚙️ Tech Stack

- Java 17
- Spring Boot
- Spring Security (JWT)
- Spring Data JPA
- PostgreSQL 17
- Keycloak
- Docker & Docker Compose
- Maven

---

## 🚀 Features

- RESTful API for core e-commerce functions
- Role-based access control with Keycloak & Spring Security
- DTO mapping and JPA Specifications for dynamic filtering
- User-specific shopping cart functionality
- Centralized validation and exception handling
- Swagger UI for API documentation

---

## 🗂️ Project Structure

```
src/
├── controller/        # REST endpoints
├── service/           # Business logic
├── repository/        # JPA repositories
├── model/             # Entities
├── dto/               # Data transfer objects
├── specifications/    # Dynamic query filters
├── annotations/       # Custom validation annotations
├── exception/         # Global exception handlers
└── config/            # Security configuration
```

---

## 🛠️ Getting Started

### Prerequisites

- Docker & Docker Compose installed

### Clone and Run

```bash
git clone https://github.com/Beost94/GolfStoreBackend.git
cd GolfStoreBackend
docker-compose up --build
```

---

## 🐳 Docker Setup

Docker Compose sets up three services:

- `springboot-app` – Backend API (port 8080)
- `keycloak` – Authentication server (port 8180)
- `postgres` – PostgreSQL database (port 5432, internal)

PostgreSQL uses an `init.sql` file to seed the schema and initial data. Volume persistence is enabled to retain data between container restarts.

---

## 🔗 Access Points

- Backend API: [http://localhost:8080](http://localhost:8080)
- Swagger UI: [http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)
- Keycloak: [http://localhost:8180](http://localhost:8180)

---

## 🔐 Authentication

JWT tokens issued by Keycloak are used for access control. Role mappings from `realm_access.roles` in the token are translated into Spring Security authorities.

### Endpoint Access Rules

- **Public:** `/products/**`
- **Protected (ROLE_USER):** `/user/**`, `/shoppingCart/**`

---

## 📄 API Documentation

Swagger UI is available at:

[http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)

---

## ✅ Validation

Validation is handled using Jakarta Bean Validation:

- `@NotBlank`, `@Size`, `@PositiveOrZero`, `@NotNull`
- Custom annotation: `@ActionConstraint` – restricts values to "Add", "Subtract", or "Delete"

---

## ❗ Exception Handling

Centralized error handling using `@RestControllerAdvice`:

- `EntityNotFoundException` → HTTP 404
- `IllegalArgumentException` → HTTP 400

---

## 📦 Build Tool

Maven is used for dependency management and building the project. The `Dockerfile` handles both build and runtime stages.

---

## 📁 Environment Configuration

Sample `application.properties` values:

```properties
spring.datasource.url=jdbc:postgresql://postgres:5432/golfshop?currentSchema=public
spring.datasource.username=postgres
spring.datasource.password=your-db-password
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect

spring.security.oauth2.resourceserver.jwt.issuer-uri=http://localhost:8180/realms/Golfshop
spring.security.oauth2.resourceserver.jwt.jwk-set-uri=http://keycloak:8080/realms/Golfshop/protocol/openid-connect/certs
```

---

## 📘 License

This project is licensed for educational and non-commercial use.
