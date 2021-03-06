import 'package:flutter/material.dart';

// provider
import 'package:provider/provider.dart';

// provider files
import 'Provider/theme_provider.dart';

// widget files
import 'Screens/completed.dart';
import 'Screens/todoList.dart';
import 'Widgets/new_todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  static const homeRoute = 'lib/home.dart';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool lightMode = false;
  int index = 0;
  final tab = <Widget>[
    TodoList(),
    CompletedToDo(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        top: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'To-Do',
            ),
            elevation: 0,
            actions: <Widget>[
              Switch.adaptive(
                activeColor: Theme.of(context).primaryColor,
                value: !themeProvider.getTheme,
                onChanged: (value) {
                  context.read<ThemeProvider>().toggleThememode(value);
                },
              )
            ],
            ),
          body: tab[index],
          floatingActionButton: FloatingActionButton(
            // foregroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.plus_one_rounded),
            onPressed: () {
              showDialog(context: context, builder: (ctx) {
                return NewTodo();
              });
            }),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: index,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_rounded), label: 'To do'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done_all_rounded), label: 'Completed'),
              ],
            ),
          ),
        );
  }
}
