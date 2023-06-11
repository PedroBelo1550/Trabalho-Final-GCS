package com.ViverBemApp.viverBem.controller;

import com.ViverBemApp.viverBem.domain.Consulta;
import com.ViverBemApp.viverBem.domain.Medico;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.ConsultaRepository;
import com.ViverBemApp.viverBem.repository.MedicoRepository;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.*;
/**
 * Controlador responsável por manipular as requisições relacionadas às consultas.
 */
@Controller
public class ConsultaController {

    private ConsultaRepository consultaRepo;
    private MedicoRepository medicoRepo;
    private PacienteRepository pacienteRepo;

    /**
     * Construtor da classe ConsultaController.
     *
     * @param consultaRepo  Repositório de consultas.
     * @param medicoRepo    Repositório de médicos.
     * @param pacienteRepo  Repositório de pacientes.
     */
    public ConsultaController(ConsultaRepository consultaRepo, MedicoRepository medicoRepo, PacienteRepository pacienteRepo){
        this.consultaRepo = consultaRepo;
        this.medicoRepo =  medicoRepo;
        this.pacienteRepo = pacienteRepo;
    }

    /**
     * Mapeamento para exibir a página de cadastro de nova consulta.
     *
     * @param model     O modelo de dados utilizado pela view.
     * @param consulta  O objeto Consulta para preenchimento dos dados.
     * @return A página de cadastro de consulta ou redirecionamento para a página inicial com parâmetros adicionais.
     */
    @GetMapping("/viverbem/novo/consulta")
    public String novaConsulta(Model model, @ModelAttribute("consulta") Consulta consulta) {

        List<Medico> listaMedicos = new ArrayList<Medico>();
        List<Paciente> listaPacientes = new ArrayList<Paciente>();

        for (Medico med:
                medicoRepo.findAll()) {
            listaMedicos.add(med);
        }

        for (Paciente pac:
                pacienteRepo.findAll()) {
            listaPacientes.add(pac);
        }


        model.addAttribute("listaPacientes", listaPacientes);
        model.addAttribute("listaMedicos", listaMedicos);

        if(listaMedicos.isEmpty() && listaPacientes.isEmpty()){
            return "redirect:/index?nenhummedicoepaciente=true";
        }
        else if(listaMedicos.isEmpty()){
            return "redirect:/index?nenhummedico=true";
        }else if(listaPacientes.isEmpty()){
            return "redirect:/index?nenhumpaciente=true";
        }
        else{
            return "cadastroConsulta";
        }
    }

    /**
     * Mapeamento para cancelar uma consulta.
     *
     * @param codigo  O código da consulta a ser cancelada.
     * @return Redirecionamento para a página inicial com parâmetros adicionais.
     * @throws IllegalArgumentException Se o código da consulta for inválido.
     */
    @GetMapping("/viverbem/consulta/cancelar/{codigo}")
    public String excluirParceiro(@PathVariable("codigo") long codigo){
        Optional<Consulta> consultaOpt = consultaRepo.findById(codigo);
        if(consultaOpt.isEmpty()){
            throw new IllegalArgumentException("Consulta inválido");
        }
        consultaRepo.delete(consultaOpt.get());

        return "redirect:/index?consultasucess=false";
    }

    /**
     * Mapeamento para exibir a página de cancelamento de consulta.
     *
     * @param model     O modelo de dados utilizado pela view.
     * @param consulta  O objeto Consulta para preenchimento dos dados.
     * @return A página de cancelamento de consulta.
     */
    @GetMapping("/viverbem/cancelar/consulta")
    public String cancelarConsulta(Model model, @ModelAttribute("consulta") Consulta consulta) {
        model.addAttribute("listaConsultas", consultaRepo.findAll());
            return "cancelarConsulta";
    }

    /**
     * Mapeamento para salvar uma consulta.
     *
     * @param consulta  O objeto Consulta a ser salvo.
     * @return Redirecionamento para a página inicial com parâmetros adicionais.
     */
    @PostMapping("/viverbem/salvar/consulta")
    public String salvarMedico(@ModelAttribute("consulta") Consulta consulta){
        consultaRepo.save(consulta);
        return "redirect:/index?consultasucess=true";
    }

}
