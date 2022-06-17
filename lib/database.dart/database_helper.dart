import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:todo/models/todo.dart';

class TodoDatabase {
  static final instance = TodoDatabase._initialize();
  static Database? _database;
  TodoDatabase._initialize();
  
  final columnId = '_id';

  Future _createDB(Database db, int version) async {
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE $todoTable (
        $columnId INTEGER PRIMARY KEY
        ${TodoFields.title} $textType,
        ${TodoFields.description} $textType,
        ${TodoFields.created} $textType,
        ${TodoFields.isChecked} $boolType,
        ${TodoFields.isFavourited} $boolType
      )''');
  }

  Future<Database> _initDB(String filename) async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, filename);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('todo.db');
      return _database;
    }
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<TodoModel> createTodoDB(TodoModel todo) async {
    final db = await instance.database;
    int id = await db!.insert(todoTable, todo.toMap());
    return todo;
  }

  Future <List<TodoModel>> queryAlltodos () async {
    final db = await instance.database;
    final maps = await db!.query(
      todoTable,
      orderBy: '${TodoFields.title} ASC',
    );
    List<TodoModel> todoList = maps.isEmpty ? []: maps.map((e) => TodoModel.fromMap(e)).toList();
    return todoList;
  }

  Future<List<TodoModel>> getTodos(String title) async {
    final db = await instance.database;
    final maps = await db!.query(
      todoTable,
      orderBy: '${TodoFields.created} DESC',
      where: '${TodoFields.title} = ?',
      whereArgs: [title]);
    return maps.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<int> editTodo(TodoModel todo) async {
    final db = await instance.database;
    int id = 1;
    return db!.update(
      todoTable,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateTodos(TodoModel todo) async {
    final db = await instance.database;
    todo.isChecked = !todo.isChecked;
    todo.isFavourited = !todo.isFavourited;
    return db!.update(
      todoTable,
      todo.toMap(),
      where: '${TodoFields.title} = ? AND ${TodoFields.description} = ?',
      whereArgs: [todo.title, todo.description]
    );
  }

  Future <int> deleteTodo (TodoModel todo) async {
    final db = await instance.database;
    return db!.delete(
      todoTable,
      where: '${TodoFields.title} = ?',
      whereArgs: [todo.title]
    );
  }
}
