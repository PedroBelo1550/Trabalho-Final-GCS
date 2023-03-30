package com.ViverBemApp.viverBem.repository;

import com.ViverBemApp.viverBem.domain.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PacienteRepository extends JpaRepository<Paciente, Long> {

}