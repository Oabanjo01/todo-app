// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Widgets/dialogs.dart';
import 'package:todo/Widgets/todo_textfield.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/Provider/todo_provider.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptioController = TextEditingController();
  }

  @override
  void dispose() {
    // done immediately the screen closes
    super.dispose();
    titleController.dispose();
    descriptioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.5,
      title: const Text(
        'New list',
        style: TextStyle(color: Colors.amber),
      ),
      actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      actions: <Widget>[
        TodotextField(
          controller: titleController,
          labelText: titleController.text.trim(),
          lines: 1,
          helpertext: 'Title',
        ),
        TodotextField(
          controller: descriptioController,
          labelText: descriptioController.text.trim(),
          lines: 4,
          helpertext: 'Description',
        ),
        TextButton.icon(
          onPressed: () async {
            if (titleController.text.trim().isEmpty ||
                descriptioController.text.trim().isEmpty) {
              showSnackBar(context, 'Input a value');
            } else {
              TodoModel todo = TodoModel(
                title: titleController.text,
                description: descriptioController.text,
                created: DateTime.now(),
              );
              if (context.read<TodoProvider>().newTodo.any((element) => element.title == todo.title)) {
                showSnackBar(context, 'Duplicate todo');
              } else {
                String result =
                    await context.read<TodoProvider>().createTodo(todo);
                if (result == 'OK!') {
                  showSnackBar(context, 'Todo Added');
                  titleController.text = '';
                  descriptioController.text = '';
                } else {
                  showSnackBar(context, result);
                }
                Navigator.pop(context);
              }
            }
          },
          icon: Icon(Icons.save_alt_rounded, color: Colors.amber),
          label: Text(
            'Add Todo',
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ],
    );
  }
}

//   TextFormField todoDescription() {
//     return TextFormField(
//           validator: (value) {
//             // if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$', multiLine: true).hasMatch(value)) {
//             //   return 'Enter a valid description';
//             // } else if (value.length <= 9) {
//             //   return 'Too short';
//             // } else {
//               return null;
//           },
//           onChanged: (description) {
//                 setState(() {
//                   this.description = description;
//               }
//             );
//           },
//           initialValue: description,
//           maxLines: 4,
//           textCapitalization: TextCapitalization.sentences,
//           decoration: InputDecoration(
//             errorStyle: const TextStyle(color: Colors.red),
//             labelText: 'Description',
//             labelStyle: TextStyle(color: Colors.black38),
//             hintText: 'Want to describe how and when?',
//             hintStyle: TextStyle(
//               fontSize: 14,
//               color: Colors.black26
//             ),
//             border: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         );
//   }

//   TextButton submitTodo(GlobalKey<FormState> _formKey, BuildContext context) {
//     return TextButton(
//             child: const Text(
//               'Add',
//               style: TextStyle(color: Colors.amberAccent),
//             ),
//             onPressed: () async {
//               final isValid = _formKey.currentState!.validate();

//               if (!isValid) {
//                 return;
//               }
//               else {
//                 final todo = TodoModel(
//                   title: title, 
//                   description: description,
//                   created: DateTime.now()
//                 );
//                 String result =await context.read<TodoProvider>().createTodo(todo);
//                 if (result != 'OK!') {
//                   showSnackBar(context, result);
//                 } else {
//                   showSnackBar(context, 'New Todo created');
//                   Navigator.pop(context);
//                 }
//               }
//               });
//   }

//   TextFormField todoTitle() {
//     return TextFormField(
//           validator: (value) {
//             if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
//               return 'Enter a valid title';
//             } else if (value.length <= 2) {
//               return 'Too short';
//             } else {
//               return null;
//             }
//           },
//           onChanged: (value) {
//             setState(() {
//               title = value;
//             });
//           },
//           initialValue: title,
//           textCapitalization: TextCapitalization.words,
//           textInputAction: TextInputAction.next,
//           decoration: InputDecoration(
//             errorStyle: const TextStyle(color: Colors.red),
//             labelText: 'Title',
//             hintText: 'What do you want to do?',
//             hintStyle: TextStyle(
//               fontSize: 14,
//               color: Colors.black26
//             ),
//             labelStyle: TextStyle(color: Colors.black38),
//             border: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.amber),
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         );
//   }
// }




// // UserSubmit(usersaved: () {
//             //   final isValid = _formKey.currentState!.validate();

//             //   if (!isValid) {
//             //     return;
//             //   }
//             //   else {
//             //     final todo = ToDoModel(
//             //       id: DateTime.now().toString(), 
//             //       text: title, 
//             //       date: DateTime.now(), 
//             //       description: description,
//             //     ),
                
//             //     provider = Provider.of<ToDoProvider>(context, listen: false);
//             //     provider.addToDO(todo);
//             //     Navigator.of(context).pop();
//             //   }
//             // })

//             // Todotitle(
//           //   titleInput: (title) {
//           //     setState(() {
//           //       this.title = title;
//           //     });
//           //   },
//           // ),

          
//           // Userdescription(
//           //   descriptionInput: (description) {
//           //     setState(() {
//           //       this.description = description;
//           //   });
//           // }),