import 'package:get/get.dart';
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository todoRepository;

  TodoController(
    {
      required this.todoRepository,     
    });
 
  var todos = <Todo>[].obs;

  Future<void> fetchTodos() async {
    final result = await todoRepository.getTodolist();
    todos.assignAll(result);
  }

  Future<void> addTodos(Todo todo) async {
    try {
      await todoRepository.addTodo(todo);
      await fetchTodos(); 
    } catch (e) {
      print('Error: $e');
    }
  }
 
  Future<void> editTodos(Todo todo) async {
    await todoRepository.editTodo(todo);
    await fetchTodos(); 
  }

  Future<void> deleteTodos(Todo todo) async {
    await todoRepository.deleteTodo(todo);
    await fetchTodos(); 
  }

}