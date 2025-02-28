package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.Loft;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoftRepository extends JpaRepository<Loft, Integer> {
}
