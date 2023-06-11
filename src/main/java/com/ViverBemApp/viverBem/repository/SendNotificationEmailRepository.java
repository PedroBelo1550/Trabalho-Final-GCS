package com.ViverBemApp.viverBem.repository;

import com.ViverBemApp.viverBem.domain.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * The SendNotificationEmailRepository interface provides methods for interacting with the database
 * to send email notifications for consultations.
 */
public interface SendNotificationEmailRepository extends JpaRepository<Consulta, Long> {

    /**
     * Saves the email notification for a consultation.
     *
     * @param consultaDTO The Consulta object containing the details of the consultation.
     */
    default void saveEmailNotification(Consulta consultaDTO) {
        Consulta consulta = new Consulta();
        consulta.setPaciente(consultaDTO.getPaciente());
        consulta.setMedico(consultaDTO.getMedico());
        consulta.setData(consultaDTO.getData());
        consulta.setHora(consultaDTO.getHora());

        save(consulta);
    }
}
