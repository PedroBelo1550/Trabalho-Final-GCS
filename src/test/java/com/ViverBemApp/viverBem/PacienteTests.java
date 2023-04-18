package com.ViverBemApp.viverBem;

import com.ViverBemApp.viverBem.domain.Paciente;
import com.ViverBemApp.viverBem.repository.PacienteRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class PacienteTests {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private PacienteRepository pacienteRepo;

	@Test
	void testaSeCadastraPaciente() throws Exception {

		//Tamanho da tabela antes do nosso teste
		Long tamanho_da_tabela = pacienteRepo.count();

		//Instanciar um paciente novo
		Paciente paciente =  new Paciente("Izabella",  "Rua 1", "11111111111", "08/12/2022");

		//Cadastrar o paciente novo na tabela por meio de um POST
		mockMvc.perform(post("http://localhost:8080/viverbem/salvar/paciente")
				.contentType("application/json")
				.content(objectMapper.writeValueAsString(paciente)))
				.andExpect(status().is(302));

		//testar se o tamanho da tabela aumentou em 1
		Assertions.assertTrue(pacienteRepo.count() == tamanho_da_tabela + 1);
	}
}