package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.GolfClubsCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GolfClubsCategoryRepository extends JpaRepository<GolfClubsCategory, Integer> {

}

