// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/todo_model.dart';
import 'package:todo/Provider/todo_provider.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({ Key? key }) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,

      child: AlertDialog(
        elevation: 0.5,
        title: const Text('New list'),
        actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        actions: <Widget>[
          todoTitle(),

          const SizedBox(
            height: 20,
          ),
          todoDescription(),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: submitTodo(_formKey, context),
          )
        ],
      ),
    );
  }

  TextFormField todoDescription() {
    return TextFormField(
          validator: (value) {
            // if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$', multiLine: true).hasMatch(value)) {
            //   return 'Enter a valid description';
            // } else if (value.length <= 9) {
            //   return 'Too short';
            // } else {
              return null;
          },
          onChanged: (description) {
                setState(() {
                  this.description = description;
              }
            );
          },
          initialValue: description,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            labelText: 'Description',
            labelStyle: TextStyle(color: Colors.black38),
            hintText: 'Want to describe how and when?',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black26
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
  }

  TextButton submitTodo(GlobalKey<FormState> _formKey, BuildContext context) {
    return TextButton(
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.amberAccent),
            ),
            onPressed: () {
              final isValid = _formKey.currentState!.validate();

              if (!isValid) {
                return;
              }
              else {
                final todo = TodoModel(
                  title: title, 
                  description: description,
                  id: DateTime.now().toString()
                ),
                
                provider = Provider.of<TodoProvider>(context, listen: false);
                provider.addTodo(todo);
                Navigator.of(context).pop();
              }});
  }

  TextFormField todoTitle() {
    return TextFormField(
          validator: (value) {
            if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              return 'Enter a valid title';
            } else if (value.length <= 2) {
              return 'Too short';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
          initialValue: title,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            labelText: 'Title',
            hintText: 'What do you want to do?',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black26
            ),
            labelStyle: TextStyle(color: Colors.black38),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
  }
}




// UserSubmit(usersaved: () {
            //   final isValid = _formKey.currentState!.validate();

            //   if (!isValid) {
            //     return;
            //   }
            //   else {
            //     final todo = ToDoModel(
            //       id: DateTime.now().toString(), 
            //       text: title, 
            //       date: DateTime.now(), 
            //       description: description,
            //     ),
                
            //     provider = Provider.of<ToDoProvider>(context, listen: false);
            //     provider.addToDO(todo);
            //     Navigator.of(context).pop();
            //   }
            // })

            // Todotitle(
          //   titleInput: (title) {
          //     setState(() {
          //       this.title = title;
          //     });
          //   },
          // ),

          
          // Userdescription(
          //   descriptionInput: (description) {
          //     setState(() {
          //       this.description = description;
          //   });
          // }),