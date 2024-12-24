package br.uel.tasksan.Tasksan.Controller;

import br.uel.tasksan.Tasksan.Model.Tarefa;
import br.uel.tasksan.Tasksan.Repository.TarefaRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TarefaController {

    @Autowired
    TarefaRepository tarefaRepository;

    // Retorna a página de Nova Tarefa ao clicar em link[/nova-tarefa]
    @GetMapping("/nova-tarefa")
    public String mostrarFormNovoContato(Tarefa tarefa) {
        return "nova-tarefa";
    }

    @GetMapping(value={"/index", "/"})
    public String mostrarListaTarefas(Model model) {
        model.addAttribute("tarefas", tarefaRepository.findAll());
        return "index";
    }

    // Adiciona uma nova tarefa no repositorio
    @PostMapping("/adicionar-tarefa")
    public String adicionarTarefa(@Valid Tarefa tarefa, BindingResult result) {
        if(result.hasErrors()) {
            return "nova-tarefa";
        }
        tarefaRepository.save(tarefa);
        return "redirect:/index";
    }

    // Método para atualizar a tarefa como finalizada
    @PostMapping("/atualizar/{id}")
    public String atualizarStatus(@PathVariable int id, @RequestParam boolean finalizado) {
        Tarefa tarefa = tarefaRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Tarefa não encontrada"));
        tarefa.setFinalizado(finalizado); // Atualiza o status da tarefa
        tarefaRepository.save(tarefa); // Salva no banco de dados
        return "redirect:/index"; // Redireciona para a página de tarefas (index)
    }

}
