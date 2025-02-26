
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';


class DeleteTodo {
  final TodoRepository todoRepository;

  DeleteTodo (this.todoRepository);
  Future <void> execute(Todo todo){
    return todoRepository.deleteTodo(todo);
  }
}