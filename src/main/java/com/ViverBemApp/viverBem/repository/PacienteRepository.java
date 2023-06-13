package com.ViverBemApp.viverBem.repository;

import com.ViverBemApp.viverBem.domain.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * The PacienteRepository interface provides methods for interacting with the database
 * to perform CRUD operations on Paciente entities.
 */
public interface PacienteRepository extends JpaRepository<Paciente, Long> {

}