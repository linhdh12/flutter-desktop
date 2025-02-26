import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';
import '../data_sources/local/todolist_db.dart';

class TodoRepositoryImplementation implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImplementation({required this.dataSource});

  @override
  Future<List<Todo>> getTodolist() async {
    return await dataSource.getTodoList();
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    await dataSource.addTodo(newTodo);
  }

  @override
  Future<void> editTodo(Todo todo) async {
    await dataSource.editTodo(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await dataSource.deleteTodo(todo);
  }
}
