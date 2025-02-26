
import 'package:equatable/equatable.dart';

class Todo extends Equatable{
  final int? id;
  final String ? title;
  final bool isCompleted;  

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false, 
  });

  @override
  List<Object?> get props => [id, title ?? '', isCompleted];

  Todo copyWith({String? title, bool? isCompleted}) {
    return Todo(
      id: id,
      title: title ?? this.title,  
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Todo toggleCompletion(){
    return Todo(
      id: id, 
      title: title,
      isCompleted: !isCompleted,
    );
  }
}
