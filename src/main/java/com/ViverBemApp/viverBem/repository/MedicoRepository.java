package com.ViverBemApp.viverBem.repository;
import com.ViverBemApp.viverBem.domain.Medico;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * The MedicoRepository interface provides methods for interacting with the database
 * to perform CRUD operations on the Medico entity.
 */
public interface MedicoRepository extends JpaRepository<Medico, Long> {

}