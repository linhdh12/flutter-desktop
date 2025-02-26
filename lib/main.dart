import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todoapp/features/todolist/presentation/pages/todolist_page.dart';
import 'package:todoapp/features/todolist/presentation/widget/injection_container.dart';

void main() async{
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      debugShowCheckedModeBanner: false,
      home: TodolistWidget(),
    );
  }
}

