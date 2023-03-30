package com.ViverBemApp.viverBem.domain;
import jakarta.persistence.*;

import java.util.List;
import java.util.Objects;

@Entity
public class Consulta {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long codigo;

    private String data;

    private String hora;

    @OneToOne
    @JoinColumn(name = "codigo_med", referencedColumnName = "codigo")
    private Medico medico;

    @OneToOne
    @JoinColumn(name = "codigo_pac", referencedColumnName = "codigo")
    private Paciente paciente;

    public Consulta(){}

    @Deprecated
    public Consulta(String data){
        this.data = data;
    }

    public Long getCodigo() {
        return codigo;
    }

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Consulta consulta = (Consulta) o;
        return Objects.equals(codigo, consulta.codigo) && Objects.equals(data, consulta.data) && Objects.equals(hora, consulta.hora) && Objects.equals(medico, consulta.medico) && Objects.equals(paciente, consulta.paciente);
    }

    @Override
    public int hashCode() {
        return Objects.hash(codigo, data, hora, medico, paciente);
    }

    @Override
    public String toString() {
        return "Consulta{" +
                "codigo=" + codigo +
                ", data='" + data + '\'' +
                ", hora='" + hora + '\'' +
                ", medico=" + medico +
                ", paciente=" + paciente +
                '}';
    }
}
