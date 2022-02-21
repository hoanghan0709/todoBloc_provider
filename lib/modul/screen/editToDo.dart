import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/model/todo_model.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditToDo extends StatefulWidget {
  TodoModel todoModel;

  EditToDo({Key? key, required this.todoModel}) : super(key: key);

  @override
  _EditToDoState createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  late TextEditingController _textTitleController = TextEditingController();
  late TextEditingController _textDateController = TextEditingController();
  List<TodoModel> _todoModel = [];
  DateTime _time = DateTime.now();
  String format(DateTime time) {
    String dateString = DateFormat('dd-MM-yyyy').format(time);
    return dateString;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textTitleController = TextEditingController(text: widget.todoModel.title);
    _textDateController =
        TextEditingController(text: widget.todoModel.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              'Update Task',
              style: TextStyle(fontSize: 50.0),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                  controller: _textTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.sort),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextFormField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2222))
                      .then((date) {
                    if (date != null) {
                      _time = date;
                    }
                    String dateString = format(_time);
                    _textDateController.text = dateString;
                  });
                },
                controller: _textDateController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    hintText: 'Date',
                    labelText: 'Date'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide())),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: () {
                  TodoModel todoModel1 = TodoModel(
                      title: _textTitleController.text,
                      docId: widget.todoModel.docId,
                      isCompleted: widget.todoModel.isCompleted,
                      id: widget.todoModel.id,
                      date: convertDate(_textDateController.text));
                  Provider.of<TodosProvider>(context, listen: false)
                      .editToDo(todoModel1);
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text(
                    'UPDATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  width: 200,
                  height: 50.0,
                  padding: EdgeInsets.only(top: 15.0),
                ))
          ],
        ),
      ),
    );
  }

  DateTime convertDate(String time) {
    var parsedDate = DateTime.parse(time);
    return parsedDate;
  }
}
