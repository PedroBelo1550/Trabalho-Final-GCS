package com.ViverBemApp.viverBem.repository;

import com.ViverBemApp.viverBem.domain.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SendNotificationEmailRepository extends JpaRepository<Consulta, Long> {

    default void saveEmailNotification(Consulta consultaDTO) {
        Consulta consulta = new Consulta();
        consulta.setPaciente(consultaDTO.getPaciente());
        consulta.setMedico(consultaDTO.getMedico());
        consulta.setData(consultaDTO.getData());
        consulta.setHora(consultaDTO.getHora());

        save(consulta);
    }
}
