package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PacienteController {

    private PacienteRepository  pacienteRepo;

    public PacienteController(PacienteRepository pacienteRepo){
        this.pacienteRepo = pacienteRepo;
    }

    @GetMapping("/index")
    public String mostrarMenu(){
        return "index";
    }

    @GetMapping("/viverbem/novo/paciente")
    public String novoPaciente(@ModelAttribute("paciente")Paciente paciente) {
        return "cadastroPaciente";
    }

    @PostMapping("/viverbem/salvar/paciente")
    public String salvarPaciente(@ModelAttribute("paciente") Paciente paciente){
        pacienteRepo.save(paciente);
        return "redirect:/index?pacientesucess=true";
    }
}
