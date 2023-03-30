package com.ViverBemApp.viverBem.domain;
import jakarta.persistence.*;

import java.util.List;
import java.util.Objects;

@Entity
public class Paciente {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long codigo;

    private String nome;

    private String endereco;

    private String telefone;

    private String data_nascimento;

    public Paciente(){}

    @Deprecated
    public Paciente(String nome, String endereco, String telefone, String data_nascimento){
       this.nome = nome;
       this.endereco = endereco;
       this.telefone = telefone;
       this.data_nascimento = data_nascimento;
    }

    public Long getCodigo() {
        return codigo;
    }

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getData_nascimento() {
        return data_nascimento;
    }

    public void setData_nascimento(String data_nascimento) {
        this.data_nascimento = data_nascimento;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Paciente paciente = (Paciente) o;
        return Objects.equals(codigo, paciente.codigo) && Objects.equals(nome, paciente.nome) && Objects.equals(endereco, paciente.endereco) && Objects.equals(telefone, paciente.telefone) && Objects.equals(data_nascimento, paciente.data_nascimento);
    }

    @Override
    public int hashCode() {
        return Objects.hash(codigo, nome, endereco, telefone, data_nascimento);
    }

    @Override
    public String toString() {
        return "Paciente{" +
                "codigo=" + codigo +
                ", nome='" + nome + '\'' +
                ", endereco='" + endereco + '\'' +
                ", telefone='" + telefone + '\'' +
                ", data_nascimento='" + data_nascimento + '\'' +
                '}';
    }
}
