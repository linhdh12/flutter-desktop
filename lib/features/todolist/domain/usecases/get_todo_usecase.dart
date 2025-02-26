
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';

class GetTodoList{
  final TodoRepository todoRepository;

  GetTodoList(this.todoRepository);
  Future <List<Todo>> call() async {
    return await todoRepository.getTodolist();
  }
}