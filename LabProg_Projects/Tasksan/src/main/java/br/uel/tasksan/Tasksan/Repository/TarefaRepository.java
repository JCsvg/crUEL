package br.uel.tasksan.Tasksan.Repository;

import br.uel.tasksan.Tasksan.Model.Tarefa;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TarefaRepository extends CrudRepository<Tarefa,Integer> { }
