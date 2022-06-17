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

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }
  getAllTodos() async {
    List<TodoModel> _todoList = [];
    if(_todoList.isEmpty) {
      _todoList = await TodoDatabase.instance.queryAlltodos();
      for (var todo in _todoList) {
        var todoModel = TodoModel(
            title: todo.title,
            description: todo.description,
            created: todo.created,
            isChecked: todo.isChecked);
        context.read<TodoProvider>().todoitem.add(todoModel); 
      }
    } else {
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return FutureBuilder<List<TodoModel>>(
      future: TodoDatabase.instance.queryAlltodos(),
      builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: Colors.amber),);
        } return
        Padding(
              padding: const EdgeInsets.all(10),
              child: Consumer<TodoProvider>(
                  builder: (context, value, child) => (value.newTodo.isEmpty)
                      ? const Center(child: Text('No Todos'))
                      : ListView.separated(
                          itemCount: value.newTodo.length,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.01,
                              ),
                          itemBuilder: (_, i) =>  Slidable(
                                key: ValueKey(i),
                                startActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.black,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                      onPressed: (context) async {
                                        TodoModel todo = value.newTodo[i];
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
                                  motion: ScrollMotion(),
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
                                                        const Text('Delete this TODO',style: TextStyle(color: Colors.amber)),
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
                                                                value.newTodo[i];
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
                                      value: value.newTodo[i].isChecked,
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
                                    title: Text(value.newTodo[i].title),
                                    subtitle: Text(value.newTodo[i].description),
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
