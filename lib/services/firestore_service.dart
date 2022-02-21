import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_todo/modul/model/todo_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> saveTodo(TodoModel todoModel) async {
    try {
      final doc = _db.collection('ToDo').doc();
      todoModel.docId = doc.id; //gan docid  = id
      final _data = todoModel.toJson();
      await doc.set(_data); //update data on serve
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteTodo(String? docId) async {
    if (docId != null) {
      try {
        await _db.collection('ToDo').doc(docId).delete();
        return true;
      } catch (_) {}
      return false;
    }
    return false;
  }

  Future<bool> editTodo(TodoModel todoModel) async {
    try {
      await _db.collection('ToDo').doc(todoModel.docId).set(todoModel.toJson());
      print(todoModel.docId);

      return true;
    } catch (_) {
      return false;
    }
  }

  Stream<QuerySnapshot> streamTodo() {
    return _db.collection('ToDo').snapshots();
  }
}
