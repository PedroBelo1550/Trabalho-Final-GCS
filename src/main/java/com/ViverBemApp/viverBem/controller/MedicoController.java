package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Medico;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.MedicoRepository;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * Controlador responsável por manipular as requisições relacionadas aos médicos.
 */
@Controller
public class MedicoController {

    private MedicoRepository medicoRepo;

    /**
     * Construtor da classe MedicoController.
     *
     * @param medicoRepo Repositório de médicos.
     */
    public MedicoController(MedicoRepository medicoRepo){
        this.medicoRepo = medicoRepo;
    }

    /**
     * Mapeamento para exibir a página de cadastro de novo médico.
     *
     * @param medico O objeto Medico para preenchimento dos dados.
     * @return A página de cadastro de médico.
     */
    @GetMapping("/viverbem/novo/medico")
    public String novoMedico(@ModelAttribute("medico") Medico medico) {
        return "cadastromedico";
    }
    
    /**
     * Mapeamento para salvar um médico.
     *
     * @param medico O objeto Medico a ser salvo.
     * @return Redirecionamento para a página inicial com parâmetros adicionais.
     */
    @PostMapping("/viverbem/salvar/medico")
    public String salvarMedico(@ModelAttribute("medico") Medico medico){
        medicoRepo.save(medico);
        return "redirect:/index?medicosucess=true";
    }

}
