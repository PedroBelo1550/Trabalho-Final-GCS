package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Consulta;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.service.SendNotificationEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import javax.mail.MessagingException;

@RestController
@RequestMapping("/api/notification")
public class SendNotificationEmailController {

    private final SendNotificationEmailService sendNotificationEmailService;

    @Autowired
    public SendNotificationEmailController(SendNotificationEmailService sendNotificationEmailService) {
        this.sendNotificationEmailService = sendNotificationEmailService;
    }

    @PostMapping("/send-email")
    public ResponseEntity<String> sendNotificationEmail(@RequestBody Consulta consultaR) {
        try {
            Paciente paciente = consultaR.getPaciente();
            Consulta consulta = new Consulta();
            consulta.setPaciente(paciente);
            consulta.setMedico(consultaR.getMedico());
            consulta.setData(consultaR.getData());
            consulta.setHora(consultaR.getHora());
            sendNotificationEmailService.sendNotificationEmail(paciente, consulta);
            return ResponseEntity.ok("Email enviado com sucesso!");
        } catch (MessagingException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Ocorreu um erro ao enviar o email.");
        }
    }
}
