import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:flutter_todo/modul/screen/addToDo.dart';
import 'package:flutter_todo/modul/screen/editToDo.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({Key? key}) : super(key: key);

  @override
  _ScreenListState createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  @override
  Widget build(BuildContext context) {
    //TodosProvider todosProvider = Provider.of<TodosProvider>(context)
    // khai bao nay la der no biet cai provider. Minh tac dong toi cai nay
    // con cai Consumer la de xuat ra man hinh
    // Provider giong Stream
    // con Consumer giong StreamBuilder

    String pickOflength =
        '${Provider.of<TodosProvider>(context).countChecked()} of ${Provider.of<TodosProvider>(context).getLength()}';

    return Scaffold(
        appBar: AppBar(
          title: Text('My Task'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 150.0, top: 20.0),
                child: Text(
                  'My Task',
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 280.0, bottom: 15.0),
                  child: Text(
                    pickOflength,
                    style: TextStyle(fontSize: 20.0),
                  )),
              Expanded(
                child: Consumer<TodosProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.getLength(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              Provider.of<TodosProvider>(context, listen: false)
                                  .removeTodo(index);
                            },
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 5.0),
                              child: ListTile(
                                tileColor: Colors.black12,
                                title: Text(
                                  value.getTodo[index].title,
                                  style: TextStyle(
                                      decoration:
                                          value.getTodo[index].isCompleted ==
                                                  false
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough),
                                ),
                                subtitle: Text(
                                    format(value.getTodo[index].Date),
                                    style: TextStyle(
                                        decoration:
                                            value.getTodo[index].isCompleted ==
                                                    false
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough)),
                                trailing: Checkbox(
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      Provider.of<TodosProvider>(context,
                                              listen: false)
                                          .toggle(index);
                                    }
                                  },
                                  value: value.getTodo[index].isCompleted,
                                )
                                // value.getTodo[index].isCompleted != _isCheck
                                //     ? Icon(Icons.check_box_outline_blank)
                                //     : Icon(
                                //   Icons.check_box,
                                //   color: Colors.red,
                                //),
                                ,
                                onTap: () {
                                  Provider.of<TodosProvider>(context,
                                          listen: false)
                                      .toggle(index);
                                },
                                onLongPress: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                          builder: (context) => EditToDo(
                                                todoModel: value.getTodo[index],
                                                index: index,
                                              ))));
                                },
                              ),
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToDo(),
                ));
          },
          child: Icon(Icons.add),
        ));
  }

  String format(DateTime time) {
    String dateString = DateFormat('dd-MM-yyyy').format(time);
    return dateString;
  }
}
