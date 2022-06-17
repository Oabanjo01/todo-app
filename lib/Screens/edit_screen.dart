import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Widgets/dialogs.dart';
import 'package:todo/Widgets/todo_textfield.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/Provider/todo_provider.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.todo}) : super(key: key);
  static const editscreen = 'lib\Screens\edit_screen.dart';
  final TodoModel todo;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        elevation: 0.5,
        iconTheme: Theme.of(context).iconTheme.copyWith(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TodotextField(
                controller: titleController,
                labelText: (widget.todo.title),
                lines: 1,
                helpertext: 'Title',
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              TodotextField(
                controller: descriptionController,
                labelText: (widget.todo.description),
                lines: 4,
                helpertext: 'Description',
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton.icon(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.amber.shade100.withOpacity(0.5))),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.amber,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                    onPressed: () async {
                      if (titleController.text.trim().isEmpty) {
                        showSnackBar(context, 'Can\t leave empty pls');
                      } else {
                        TodoModel editTodo = TodoModel(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          created: widget.todo.created,
                        );
                        if (context.read<TodoProvider>().newTodo.any(
                            (element) =>
                                element.title == editTodo.title ||
                                element.description == editTodo.description)) {
                          showSnackBar(context, 'Duplicate todo');
                        } else {
                          await context.read<TodoProvider>().updateTodo(editTodo);
                          Navigator.of(context).pop();
                        }
                      }
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    child: Text(
                      DateFormat.yMMMd().format(widget.todo.created),
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

// TextFormField todoDescription() {
//     return ;
//   }

//   TextFormField todoTitle() {
//     return ;
//   }
// }
