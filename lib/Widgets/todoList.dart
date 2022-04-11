// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';
import 'package:todo/Provider/todo_model.dart';
import 'package:todo/Provider/todo_provider.dart';
import 'package:todo/Screens/edit_screen.dart';

import 'pop_info.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // bool value = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: provider.todo.isEmpty
          ? Center(child: Text('No Todos'))
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: size.height * 0.01,
              ),
              itemBuilder: (_, i) {
                final todo = provider.todo[i];
                // final Map<String, dynamic> todoData = {
                //   'todo': todo,
                //   'title': todo.title,
                //   'description': todo.description
                // };
                //where the mistake was made apparently
                return Slidable(
                  key: ValueKey(i),
                  startActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        icon: Icons.edit,
                        label: 'Edit',
                        onPressed: (context) {
                          editTodo(context, todo);
                          // Navigator.of(context).pushNamed(
                          //   EditScreen.editscreen,
                          //   arguments: todoData
                          // );
                          PopScaffold.showSnackBar(context,
                              'Edit ${todo.title}?');
                        },
                      ),
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
                        onPressed: (context) {
                          final slideTodo = todo;
                          final providerEdit =
                              Provider.of<TodoProvider>(context, listen: false);

                          providerEdit.deleteToDo(
                            slideTodo,
                          );
                          PopScaffold.showSnackBar(
                            context,
                            'Deleted ${todo.title}',
                          );
                          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Deleted ${todo.title}')
                          //       // action: SnackBarAction,
                          //       ),
                          //   );
                        },
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      editTodo(context, todo);
                      PopScaffold.showSnackBar(context,
                          'Edit ${todo.title}',);
                    },
                    child: ListTile(
                      tileColor: theme.primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        value: todo.isChecked,
                        activeColor: theme.primaryColorDark,
                        checkColor: theme.primaryColorLight,
                        onChanged: (_) {
                          // return setState(() {  // this works too
                          //   todo.isChecked = value;
                          // });
                  
                          final isDone =
                              Provider.of<TodoProvider>(context, listen: false);
                  
                          isDone.toggleTodoStatus(todo);
                        },
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      // trailing: IconButton(
                      //   onPressed: () {
                  
                      //   },
                      //   icon: (value == false) ? const Icon(Icons.favorite_outline_rounded) : const Icon(Icons.favorite),
                      // ),
                    ),
                  ),
                );
              },
              itemCount: provider.todo.length,
            ),
    );
  }
}

void editTodo(BuildContext context, TodoModel todo) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditScreen(todo: todo),
    ),
  );
}
