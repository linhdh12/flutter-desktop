import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:todoapp/features/todolist/presentation/pages/todolist_page.dart';
import 'package:todoapp/cores/util/injection_container.dart';

void main() async{
  if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb; 
    } else {
      databaseFactory = databaseFactoryFfi;
    }
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

