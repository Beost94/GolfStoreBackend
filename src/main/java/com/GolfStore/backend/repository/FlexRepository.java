package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.Flex;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FlexRepository extends JpaRepository<Flex, Integer> {
}
