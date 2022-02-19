
class TodoModel {
  late int id;
  String title = '';
  DateTime Date = DateTime.now();
  bool isCompleted;

  TodoModel(
      {required this.title, required this.Date, this.isCompleted = false});

  void toggle() {
    this.isCompleted = !this.isCompleted;
  }

  TodoModel copyWith(String title, DateTime dateTime  ) => TodoModel(title: title,Date: dateTime);
}
