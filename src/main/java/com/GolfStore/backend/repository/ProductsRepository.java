package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductsRepository extends JpaRepository<Products, Integer> {
    /* Nå arver denne interfacen alle metodene som JpaRepository har.
    findall(), findbyID(), save(), deletebyid()
     */

    /* Eksempel på en custom. findByCategoryid, da bruker den WHERE categoryid = *  */

    List<Products> findByCategoryid (Products categoryid);
}
