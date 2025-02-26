import 'package:todoapp/features/todolist/domain/entities/todo.dart';

class TodoModel {
  final int? id;
  final String title;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }

  factory TodoModel.fromEntity(Todo entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title!,
      isCompleted: entity.isCompleted,
    );
  }

}

