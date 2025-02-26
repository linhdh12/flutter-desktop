import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todoapp/features/todolist/domain/entities/todo.dart';

  class TodoDataSource {
  Database? _database;

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todos.db');
    return await databaseFactoryFfi.openDatabase(
    path,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    )
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<List<Todo>> getTodoList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'] as int?,
        title: maps[i]['title'] as String?,
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  Future<void> addTodo(Todo newTodo) async {
    final db = await database;
    await db.insert(
      'todos',
      {
        'title': newTodo.title,
        'isCompleted': newTodo.isCompleted ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      {
        'title': todo.title,
        'isCompleted': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}