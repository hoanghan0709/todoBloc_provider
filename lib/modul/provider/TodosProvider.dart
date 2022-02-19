

import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/model/todo_model.dart';

class TodosProvider with ChangeNotifier {
  List<TodoModel> _todo = [];
  List<TodoModel> get getTodo=> _todo;

  void addTodo(String title,DateTime date){
    TodoModel todo = TodoModel( title:title, Date:date);
    print('aaaaaaaaaaaa');
    _todo.add(todo);
    notifyListeners();
  }

  int getLength(){
    return _todo.length;
  }

  int countChecked(){
    return _todo.where((element) => element.isCompleted ==true).toList().length;
  }

  void toggle(int index){
    _todo[index].toggle();
    notifyListeners();
  }
  void removeTodo(int index){
    _todo.removeAt(index);
    notifyListeners();
  }
  void editToDo({required String title,required DateTime dateTime,required int index}){
    _todo[index] =getTodo[index].copyWith(title,dateTime);
    notifyListeners();
  }
}