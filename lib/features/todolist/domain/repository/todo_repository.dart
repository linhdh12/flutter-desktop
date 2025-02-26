
import 'package:todoapp/features/todolist/domain/entities/todo.dart';

abstract class TodoRepository {
  Future <List<Todo>> getTodolist();

  Future<void> addTodo( Todo newTodo);

  Future<void> editTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);
}