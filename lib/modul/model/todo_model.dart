import 'package:uuid/uuid.dart';

class TodoModel {
  int? id = DateTime.now().hashCode;
  String? docId;
  final String? title;
  DateTime? date = DateTime.now();
  late bool isCompleted;

  TodoModel(
      {this.id,
      this.docId,
      required this.title,
      this.date,
      this.isCompleted = false});

  void toggle() {
    this.isCompleted = !this.isCompleted;
  }

  TodoModel copyWith(int id, String title, DateTime dateTime) =>
      TodoModel(id: id, title: title, date: dateTime);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'docId': docId,
      'title': title,
      'date': date,
      'isCompleted': isCompleted,
    };
  }

  TodoModel.fromJson(Map<String, dynamic> firebaseFireStore)
      : id = firebaseFireStore['id'],
        docId = firebaseFireStore['docId'],
        title = firebaseFireStore['title'],
        date = firebaseFireStore['date']?.toDate(),
        isCompleted = firebaseFireStore['isCompleted'];
}
