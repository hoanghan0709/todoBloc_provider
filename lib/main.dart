import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:flutter_todo/modul/screen/homeToDo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenList(),
      ),
    );
  }
}
