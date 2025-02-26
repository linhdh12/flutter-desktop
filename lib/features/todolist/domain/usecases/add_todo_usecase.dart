
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';

class AddTodo {
  final TodoRepository todoRepository;

  AddTodo(this.todoRepository);
  Future <void> excute(Todo newTodo){
    return todoRepository.addTodo(newTodo);
  }
}