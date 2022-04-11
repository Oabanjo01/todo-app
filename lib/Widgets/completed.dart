import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:todo/Provider/todo_provider.dart';
import 'pop_info.dart';

class CompletedToDo extends StatefulWidget {
  const CompletedToDo({Key? key}) : super(key: key);

  @override
  State<CompletedToDo> createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDo> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: provider.todoCompleted.isEmpty
          ? Center(child: Text('No Completed Todos'))
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: size.height * 0.01,
              ),
              itemBuilder: (_, i) {
                final completedTodos = provider
                    .todoCompleted[i]; //where the mistake was made apparently
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
                          PopScaffold.showSnackBar(
                            context,
                            'Edit ${completedTodos.title}?',
                          );
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
                          final slideTodo = completedTodos;

                          final providerEdit =
                              Provider.of<TodoProvider>(context, listen: false);

                          providerEdit.deleteToDo(
                            slideTodo,
                          );
                          PopScaffold.showSnackBar(
                            context,
                            'Deleted ${completedTodos.title}',
                          );
                          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Deleted ${completedTodos.title}')
                          //       // action: SnackBarAction,
                          //       ),
                          //   );
                        },
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: theme.primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      value: completedTodos.isChecked,
                      activeColor: theme.primaryColorDark,
                      checkColor: theme.primaryColorLight,
                      onChanged: (_) {
                        // return setState(() {  // this works too
                        //   completedTodos.isChecked = value;
                        // });

                        final isDone =
                            Provider.of<TodoProvider>(context, listen: false);

                        isDone.toggleTodoStatus(completedTodos);
                      },
                    ),
                    title: Text(completedTodos.title),
                    subtitle: Text(completedTodos.description),
                    // trailing: IconButton(
                    //   onPressed: () {

                    //   },
                    //   icon: (value == false) ? const Icon(Icons.favorite_outline_rounded) : const Icon(Icons.favorite),
                    // ),
                  ),
                );
              },
              itemCount: provider.todoCompleted.length,
            ),
    );
  }
}
