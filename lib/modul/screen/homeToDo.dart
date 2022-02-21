import 'package:flutter/material.dart';
import 'package:flutter_todo/modul/provider/TodosProvider.dart';
import 'package:flutter_todo/modul/screen/Completed.dart';
import 'package:flutter_todo/modul/screen/addToDo.dart';
import 'package:flutter_todo/modul/screen/editToDo.dart';

import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [ScreenList(), ScreenCompleted()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.blue,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.check),
      title: ("Completed"),
      activeColorPrimary: Colors.red,
      inactiveColorPrimary: Colors.red,
    ),
  ];
}

class ScreenList extends StatefulWidget {
  const ScreenList({Key? key}) : super(key: key);

  @override
  _ScreenListState createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  @override
  void initState() {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.init();
    super.initState();
  }

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
                                  .removeTodo(value.getTodo[index].docId);
                            },
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 5.0),
                              child: ListTile(
                                tileColor: Colors.black12,
                                title: Text(
                                  value.getTodo[index].title ?? '',
                                  style: TextStyle(
                                      decoration:
                                          value.getTodo[index].isCompleted ==
                                                  false
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough),
                                ),
                                subtitle: Text(
                                    format(value.getTodo[index].date),
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
                                ),
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

  String format(DateTime? time) {
    if (time != null) {
      String dateString = DateFormat('dd-MM-yyyy').format(time);
      return dateString;
    }
    return 'n/a';
  }
}
