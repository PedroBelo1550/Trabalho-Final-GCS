package com.ViverBemApp.viverBem.repository;

import com.ViverBemApp.viverBem.domain.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * The ConsultaRepository interface provides methods for interacting with the database
 * to perform CRUD operations on the Consulta entity.
 */
public interface ConsultaRepository extends JpaRepository<Consulta, Long> {

}