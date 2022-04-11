import 'package:flutter/material.dart';

import 'todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todoItem = [
    TodoModel(
      title: 'Buy an egg',
      description: 'Buy an egg for the house',
    ),
  ];

  List<TodoModel> get todo {
    return [
      ..._todoItem.where((element) => element.isChecked == false).toList()
    ];
  }

  List<TodoModel> get todoCompleted {
    return [
      ..._todoItem.where((element) => element.isChecked == true).toList()
    ];
  }

  void addTodo(TodoModel todo) {
    _todoItem.add(todo);
    notifyListeners();
  }

  deleteToDo(TodoModel deletetodo) {
    _todoItem.remove(deletetodo);

    notifyListeners();
  }

  void updateTodo (TodoModel updatetodo, String? title, String? description) {
    
    updatetodo.title = title!;
    updatetodo.description = description!;

    notifyListeners();
  }


  bool toggleTodoStatus(TodoModel todo) {
    todo.isChecked = !todo.isChecked;
    notifyListeners();

    return todo.isChecked;
  }

  bool isFavourite(TodoModel todo) {
    todo.isFavourited = !todo.isFavourited;
    notifyListeners();

    return todo.isFavourited;
  }
}
