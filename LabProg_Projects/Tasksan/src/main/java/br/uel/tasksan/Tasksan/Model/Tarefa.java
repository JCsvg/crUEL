package br.uel.tasksan.Tasksan.Model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class Tarefa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank(message = "O título é obrigatório")
    private String titulo;

    private String descricao;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private java.util.Date prazo;

    @Column(name = "finalizada")
    private boolean finalizado = false;

    //-----Override-----//
    @Override
    public boolean equals(Object o){
        if (o == null || this.getClass() != o.getClass()) {
            return false;
        }
        return ((Tarefa)o).id == (this.id);
    }

    @Override
    public int hashCode() {
        return id * 12345;
    }


    //-----Get & Set-----//
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}

    public String getTitulo() {return titulo;}
    public void setTitulo(String titulo) {this.titulo = titulo;}

    public String getDescricao() {return descricao;}
    public void setDescricao(String descricao) {this.descricao = descricao;}

    public java.util.Date getPrazo() {return prazo;}
    public void setPrazo(java.util.Date prazo) {this.prazo = prazo;}

    public boolean getFinalizado() {return finalizado;}
    public void setFinalizado(boolean finalizado) {this.finalizado = finalizado;}
}

