
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/config/contanst/appcontanst.setting.dart';
import 'package:todoapp/features/todolist/domain/entities/todo.dart';
import 'package:todoapp/features/todolist/presentation/controller/todo_controller.dart';
import 'package:todoapp/features/todolist/presentation/widget/injection_container.dart';

class TodolistWidget extends StatefulWidget {
  const TodolistWidget({super.key});

  @override
  State<TodolistWidget> createState() => _TodolistWidgetState();
}

class _TodolistWidgetState extends State<TodolistWidget> {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = getIt<TodoController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade900,
        title: Center(
          child: Text(
                  'Todo App',
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: Colors.white)
                ),
        ),              
      ),     
      body: Obx(() {
        return todoController.todos.isEmpty
          ? Center(child: Text('Not found'),)
          : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                height: 1000,
                width: 800,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tasks',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showAddTodoDialog(context, todoController);
                            },
                            child: Text('Add Task'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.greenAccent.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: AppcontanstSetting().boderRadius
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(                                           
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: AppcontanstSetting().boderRadius,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 5.0),
                        ],
                      ),                                          
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: todoController.todos.length,
                          itemBuilder: (context, index){
                            Todo todo = todoController.todos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),                    
                          child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,  
                            children: [
                              Checkbox(
                                value: todo.isCompleted, 
                                onChanged: (bool? value) {
                                  todoController.editTodos(todo.toggleCompletion());
                                },
                              ),
                              Container(
                                width: 2.0,  
                                color: Colors.grey,  
                                height: 24.0,  
                              ),
                              SizedBox(width: 10.0,),                  
                              Expanded(
                                child: Text(
                                  todo.title ?? '',
                                  maxLines: 2,  
                                  overflow: TextOverflow.ellipsis,  
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),                
                              Row(
                                mainAxisSize: MainAxisSize.min,  
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _showEditDialog(context, todoController, todo);
                                    },
                                    icon: Icon(Icons.edit, color: Colors.black,),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      todoController.deleteTodos(todo);
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },)
    );
  }

  void _showEditDialog(BuildContext context, TodoController todoController, Todo todo) {
  final TextEditingController _controller = TextEditingController(text: todo.title);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit todo'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter new todo'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                todoController.editTodos(todo.copyWith(title: _controller.text));
              }
              Navigator.of(context).pop();
            },
            child: Text('Ok', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),         
        ],
         shape: RoundedRectangleBorder(
          borderRadius: AppcontanstSetting().boderRadius,
        ),
      );
    },
  );
}

  void _showAddTodoDialog(BuildContext context, TodoController todoController) {
  final TextEditingController textController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add new todo'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Enter the todo title',            
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                Todo newTodo = Todo(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: textController.text,
                );
                todoController.addTodos(newTodo).then((_) {
                  Navigator.pop(context); 
                }).catchError((e) {
                  print('Error: $e');
                });
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a title for the todo')),
                );
              }
            },
            child: Text('Ok', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: AppcontanstSetting().boderRadius,
        ),
      );
    },
  );

}
}