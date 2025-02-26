
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todoapp/features/todolist/data/data_sources/local/todolist_db.dart';
import 'package:todoapp/features/todolist/data/repository/todo_repository_impl.dart';
import 'package:todoapp/features/todolist/domain/repository/todo_repository.dart';
import 'package:todoapp/features/todolist/presentation/controller/todo_controller.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  getIt.registerSingleton<TodoDataSource>(TodoDataSource());

  getIt.registerSingleton<TodoRepository>(
    TodoRepositoryImplementation(dataSource: getIt<TodoDataSource>()),
  );

  getIt.registerSingleton<TodoController>(
    TodoController(todoRepository: getIt<TodoRepository>())
  );

  await getIt<TodoController>().fetchTodos();
}