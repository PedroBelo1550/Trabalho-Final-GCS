package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Medico;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.MedicoRepository;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MedicoController {

    private MedicoRepository medicoRepo;

    public MedicoController(MedicoRepository medicoRepo){
        this.medicoRepo = medicoRepo;
    }

    @GetMapping("/viverbem/novo/medico")
    public String novoMedico(@ModelAttribute("medico") Medico medico) {
        return "cadastromedico";
    }

    @PostMapping("/viverbem/salvar/medico")
    public String salvarMedico(@ModelAttribute("medico") Medico medico){
        medicoRepo.save(medico);
        return "redirect:/index?medicosucess=true";
    }

}
