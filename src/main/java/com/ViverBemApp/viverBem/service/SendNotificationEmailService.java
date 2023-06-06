package com.ViverBemApp.viverBem.service;


import com.ViverBemApp.viverBem.domain.Consulta;
import com.ViverBemApp.viverBem.domain.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@Service
public class SendNotificationEmailService {

    private final JavaMailSender javaMailSender;

    @Autowired
    public SendNotificationEmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendNotificationEmail(Paciente paciente, Consulta consulta) throws MessagingException {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(paciente.getEmail());

        LocalDate dataConsulta = consulta.getData();
        LocalTime horaConsulta = consulta.getHora();



        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String dataFormatada = dataConsulta.format(dateFormatter);

        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        String horaFormatada = horaConsulta.format(timeFormatter);

        String dataHoraConsulta = dataFormatada+ " às " + horaFormatada;


        message.setSubject("Consulta agendada");
        message.setText("Olá " + paciente.getNome() + ", sua consulta com o médico " + consulta.getMedico().getNome() + " foi agendada para " + dataHoraConsulta + ".");

        javaMailSender.send(message);
    }


}
