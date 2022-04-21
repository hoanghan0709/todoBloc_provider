import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScreenCompleted extends StatefulWidget {
  const ScreenCompleted({Key? key}) : super(key: key);

  @override
  _ScreenCompletedState createState() => _ScreenCompletedState();
}

class _ScreenCompletedState extends State<ScreenCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COMPLETED'),
        ),
        body: Column(
          children: [
            Text(
              'Completed',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Expanded(child: Consumer<TodosProvider>(
              builder: (context, value, child) {
                print(value.getCompletedTodo);
                print(value.getCompletedTodo);
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 5.0),
                      child: ListTile(
                        trailing: Icon(Icons.check,color: Colors.green,),
                        title: Text(value.getCompletedTodo[index].title ?? ''),
                        subtitle:
                            Text(format(value.getCompletedTodo[index].date)),
                      ),
                    );
                  },
                  itemCount: value.getCompletedTodo.length,
                );
              },
            ))
          ],
        ));
  }

  String format(DateTime? time) {
    if (time != null) {
      String dateString = DateFormat('dd-MM-yyyy').format(time);
      return dateString;
    }
    return 'n/a';
  }
}
