
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';

class EditTodo {
  final TodoRepository todoRepository;

  EditTodo (this.todoRepository);

  Future <void> excute (Todo todo){
    return todoRepository.editTodo(todo);
  }
}