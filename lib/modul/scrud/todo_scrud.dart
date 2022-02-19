
import 'package:flutter_todo/modul/model/todo_model.dart';

class ManagerToDo{
  static ManagerToDo instance =  ManagerToDo.internal();

  ManagerToDo.internal();

  factory ManagerToDo()=> instance;

  List<TodoModel> _todo =<TodoModel>[];
  List<TodoModel> get gettodo=> _todo;

  void addTodo(String title,DateTime date){
    TodoModel todo = new TodoModel( title:title, Date:date);
    _todo.add(todo);

  }
  void removeTodo(int index) {
    _todo.remove(index);
  }
}