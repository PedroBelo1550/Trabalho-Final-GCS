package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.JavaMailApp;
import com.ViverBemApp.viverBem.domain.Consulta;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.service.SendNotificationEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import javax.mail.MessagingException;

/**
 * Controlador responsável por manipular as requisições relacionadas ao envio de notificação por e-mail.
 */
@Controller
public class SendNotificationEmailController {

    private final SendNotificationEmailService sendNotificationEmailService;

    /**
     * Construtor da classe SendNotificationEmailController.
     *
     * @param sendNotificationEmailService O serviço de envio de notificação por e-mail.
     */
    @Autowired
    public SendNotificationEmailController(SendNotificationEmailService sendNotificationEmailService) {
        this.sendNotificationEmailService = sendNotificationEmailService;
    }

    /**
     * Mapeamento para enviar uma notificação por e-mail.
     *
     * @param consultaR A consulta relacionada à notificação.
     * @return Uma resposta HTTP com o status e uma mensagem de sucesso.
     * @throws MessagingException Se ocorrer um erro durante o envio do e-mail.
     */
    @PostMapping("/send-email")
    public ResponseEntity<String> sendNotificationEmail(@RequestBody Consulta consultaR) throws MessagingException {
        Paciente paciente = consultaR.getPaciente();
        Consulta consulta = new Consulta();
        consulta.setPaciente(paciente);
        consulta.setMedico(consultaR.getMedico());
        consulta.setData(consultaR.getData());
        consulta.setHora(consultaR.getHora());
         sendNotificationEmailService.sendNotificationEmail(paciente, consulta);
        JavaMailApp mailApp = new JavaMailApp();
        mailApp.sendEmail();
        return ResponseEntity.ok("Email enviado com sucesso!");
    }
}
