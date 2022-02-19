import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  // final managerTodo = ManagerToDo();

  late TextEditingController _textTitleController;
  late TextEditingController _textDateController;
  DateTime _time = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    _textTitleController = TextEditingController();
    _textDateController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Appbar'),
        ),
        body: Container(
          child: addToDo(context),
        ));
  }

  Widget addToDo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Text(
            'Add Task',
            style: TextStyle(fontSize: 50.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _textTitleController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.sort),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3.0, color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                hintText: 'Title',
                labelText: 'Title'),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
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

                String dateString = DateFormat('dd-MM-yyyy').format(_time);
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
          SizedBox(
            height: 20.0,
          ),
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide())),
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () {
                Provider.of<TodosProvider>(context, listen: false)
                    .addTodo(_textTitleController.text, _time);
                Navigator.pop(context);
              },
              child: Container(
                child: Text(
                  'CONFIRM',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                width: 200,
                height: 50.0,
                padding: EdgeInsets.only(top: 15.0),
              ))
        ],
      ),
    );
  }
}//count check of maxlength
