package com.ViverBemApp.viverBem;

import com.ViverBemApp.viverBem.domain.Consulta;
import com.ViverBemApp.viverBem.domain.Medico;
import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.ConsultaRepository;
import com.ViverBemApp.viverBem.repository.MedicoRepository;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class ConsultaTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private MedicoRepository medicoRepo;

    @Autowired
    private ConsultaRepository consultaRepo;

    @Autowired
    private PacienteRepository pacienteRepo;

    @Test
    void testaSeCadastraConsulta() throws Exception {

        //Tamanho da tabela antes do nosso teste
        Long tamanho_da_tabela = consultaRepo.count();

        //Instanciar um paciente, um medico e uma consulta
        Consulta consulta = new Consulta("08/10/2012");

        //Cadastrar o paciente novo na tabela por meio de um POST
        mockMvc.perform(post("http://localhost:8080/viverbem/salvar/consulta")
                .contentType("application/json")
                .content(objectMapper.writeValueAsString(consulta)))
                .andExpect(status().is(302));

        //testar se o tamanho da tabela aumentou em 1
        Assertions.assertTrue(consultaRepo.count() == tamanho_da_tabela + 1);
    }
}