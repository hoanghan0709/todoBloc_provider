import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/model/todo_model.dart';
import 'package:flutter_todo/services/firestore_service.dart';
import 'package:flutter_todo/setup/locator.dart';

class TodosProvider with ChangeNotifier {
  final firebaseFirestore = locator<FirestoreService>();

  List<TodoModel> _todo = [];
  List<TodoModel> get getTodo => _todo;
  List<TodoModel> get getCompletedTodo =>
      _todo.where((element) => element.isCompleted == true).toList();

  void addTodo(String title, DateTime date) {
    TodoModel todo = TodoModel(title: title, date: date, isCompleted: false);
    firebaseFirestore.saveTodo(todo);
    notifyListeners();
  }

  void changeTodo(TodoModel data) {
    _todo.add(data);
    notifyListeners();
  }

  void statusRemove(TodoModel data) {
    _todo.removeWhere((element) => element.docId == data.docId);
    notifyListeners();
  }

  void statusUpdate(TodoModel todoModel) {
    final index =
        _todo.indexWhere((element) => element.docId == todoModel.docId);
    _todo[index] = todoModel;
    notifyListeners();
  }

  void init() {
    firebaseFirestore.streamTodo().listen((snapshot) {
      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final doc = change.doc.data() as Map<String, dynamic>;

          final todo = TodoModel.fromJson(doc);

          changeTodo(todo);
        } else if (change.type == DocumentChangeType.removed) {
          final doc = change.doc.data() as Map<String, dynamic>;

          final todo = TodoModel.fromJson(doc);
          statusRemove(todo);
        } else if (change.type == DocumentChangeType.modified) {
          final doc = change.doc.data() as Map<String, dynamic>;

          final todo = TodoModel.fromJson(doc);
          statusUpdate(todo);
        }
      }
    });
  }

  int getLength() {
    return _todo.length;
  }

  int countChecked() {
    return _todo
        .where((element) => element.isCompleted == true)
        .toList()
        .length;
  }

  void toggle(int index) {
    _todo[index].toggle();
    notifyListeners();
  }

  void removeTodo(String? docId) {
    if (docId != null) {
      firebaseFirestore.deleteTodo(docId);
      notifyListeners();
    }
  }

  void editToDo(TodoModel todoModel) {
    firebaseFirestore.editTodo(todoModel);
  }
}
