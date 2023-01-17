import 'package:flutter/material.dart';
import 'package:todo/database.dart/database_helper.dart';

import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todoItem = [];

  List<TodoModel> get todoitem {
    return _todoItem;
  }

  List<TodoModel> get newTodo {
    return [
      ..._todoItem.where((element) => element.isChecked == false).toList()
    ];
  }

  List<TodoModel> get todoCompleted {
    return [
      ..._todoItem.where((element) => element.isChecked == true).toList()
    ];
  }

  Future <String> getTodos () async {
    try{
      _todoItem = await TodoDatabase.instance.queryAlltodos();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'OK!';
  }

  Future <String> createTodo (TodoModel todo) async {
    try{
      await TodoDatabase.instance.createTodoDB(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos();
    return result;
  }

  Future<String> deleteToDo (TodoModel todo) async {
    try{
      await TodoDatabase.instance.deleteTodo(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos();
    return result;
  }

    Future <String> editTodo (TodoModel todo) async {
    try{
      await TodoDatabase.instance.updateTodos(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos();
    return result;
  }
  
  Future <String> updateTodo (TodoModel todo) async {
    try{
      await TodoDatabase.instance.updateTodos(todo);
    } catch (e) {
      return e.toString();
    }
    String result = await getTodos();
    return result;
  }
}
