import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/todo_model.dart';
import 'package:todo/Provider/todo_provider.dart';

class EditScreen extends StatefulWidget {
  EditScreen({ Key? key, required this.todo}) : super(key: key);
  static const editscreen = 'lib\Screens\edit_screen.dart';
  final TodoModel todo;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override

  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // var editTitle = data['title'];
    // var editDescription = data['description'];
    // var editTodo = data['todo'] as TodoModel;
    // final title = editTitle;
    // final description = editDescription;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        elevation: 0.5,
        iconTheme: Theme.of(context).iconTheme.copyWith(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
              ),
              SizedBox(height: 30,),
              TextFormField(
                validator: (value) {
                    return null;
                },
                onChanged: (value) {
                      setState(() {
                        description = value;
                    }
                  );
                },
                initialValue: description,
                maxLines: 10,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red),
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.black38),
                  hintText: 'Want to describe how and when?',
                  hintStyle: const TextStyle(
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
              ),
              TextButton(
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.amberAccent),
                ),
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
              
                  if (!isValid) {
                    return;
                  }
                  else {
                    // final todo = editTodo,
                    // // TodoModel(
                    // //   title: editTitle as String, 
                    // //   description: editDescription as String,
                    // //   id: DateTime.now().toString()
                    // // ),
                    
                    final provider = Provider.of<TodoProvider>(context, listen: false);
                    provider.updateTodo(widget.todo, title, description);
                    Navigator.of(context).pop();
                  }}),
            ]),
          ),
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