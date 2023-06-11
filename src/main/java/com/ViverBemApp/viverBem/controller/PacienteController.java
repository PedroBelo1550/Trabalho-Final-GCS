package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * Controlador responsável por manipular as requisições relacionadas aos pacientes.
 */
@Controller
public class PacienteController {

    private PacienteRepository  pacienteRepo;

    /**
     * Construtor da classe PacienteController.
     *
     * @param pacienteRepo Repositório de pacientes.
     */
    public PacienteController(PacienteRepository pacienteRepo){
        this.pacienteRepo = pacienteRepo;
    }

    /**
     * Mapeamento para exibir o menu principal.
     *
     * @return A página do menu principal.
     */
    @GetMapping("/index")
    public String mostrarMenu(){
        return "index";
    }

    /**
     * Mapeamento para exibir a página de cadastro de novo paciente.
     *
     * @param paciente O objeto Paciente para preenchimento dos dados.
     * @return A página de cadastro de paciente.
     */    
    @GetMapping("/viverbem/novo/paciente")
    public String novoPaciente(@ModelAttribute("paciente")Paciente paciente) {
        return "cadastroPaciente";
    }

    /**
     * Mapeamento para salvar um paciente.
     *
     * @param paciente O objeto Paciente a ser salvo.
     * @return Redirecionamento para a página inicial com parâmetros adicionais.
     */
    @PostMapping("/viverbem/salvar/paciente")
    public String salvarPaciente(@ModelAttribute("paciente") Paciente paciente){
        pacienteRepo.save(paciente);
        return "redirect:/index?pacientesucess=true";
    }
}
