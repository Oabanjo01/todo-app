// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';
import 'package:todo/Widgets/dialogs.dart';
import 'package:todo/database.dart/database_helper.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/Provider/todo_provider.dart';
import 'package:todo/Screens/edit_screen.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({Key? key}) : super(key: key);

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    
    var todos = await TodoDatabase.instance.queryAlltodos();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return FutureBuilder<List<TodoModel>>(
      future: TodoDatabase.instance.queryAlltodos(),
      builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: Colors.amber,),);
        } return Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<TodoProvider>(
                builder: (context, value, child) => (value.todoCompleted.isEmpty)
                    ? const Center(child: Text('No Todos'))
                    : ListView.separated(
                        itemCount: value.todoCompleted.length,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                              height: size.height * 0.01,
                            ),
                        itemBuilder: (_, i) => Slidable(
                              key: ValueKey(i),
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.black,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                    onPressed: (context) async {
                                      TodoModel todo = value.todoCompleted[i];
                                      editTodo(context, todo);
                                      // Navigator.of(context).pushNamed(
                                      //   EditScreen.editscreen,
                                      //   arguments: todoData
                                      // );
                                      showSnackBar(
                                          context, 'Edit ${todo.title}?');
                                    },
                                  )
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.black,
                                      spacing: 0,
                                      icon: Icons.delete,
                                      label: 'delete',
                                      onPressed: (context) async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  title:
                                                      const Text('Delete this TODO', style: TextStyle(color: Colors.amber),),
                                                  content:
                                                      const Text('Are you Sure?'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('No',style: TextStyle(color: Colors.amber)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                        child: const Text('Yes',style: TextStyle(color: Colors.amber)),
                                                        onPressed: () async {
                                                          TodoModel todo =
                                                              value.todoCompleted[i];
                                                          String result =
                                                              await context
                                                                  .read<
                                                                      TodoProvider>()
                                                                  .deleteToDo(
                                                                      todo);
                                                          if (result != 'OK!') {
                                                            return showSnackBar(
                                                                context,
                                                                result);
                                                          } else {
                                                            showSnackBar(
                                                                context,
                                                                'Deleted');
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        })
                                                  ]);
                                            });
                                      })
                                ],
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  tileColor: theme.primaryColorLight,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    value: value.todoCompleted[i].isChecked,
                                    activeColor: theme.primaryColorDark,
                                    checkColor: theme.primaryColorLight,
                                    onChanged: (_) async {
                                      // return setState(() {  // this works too
                                      //   todo.isChecked = value;
                                      // });
                                      TodoModel todo = value.todoitem[i];

                                      await context
                                          .read<TodoProvider>()
                                          .updateTodo(todo);
                                    },
                                  ),
                                  title: Text(value.todoCompleted[i].title),
                                  subtitle: Text(value.todoCompleted[i].description),
                                ),
                              ),
                            ))),
          );
  });
  }
}

void editTodo(BuildContext context, TodoModel todo) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditScreen(todo: todo),
    ),
  );
}
