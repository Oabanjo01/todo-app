// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo/Provider/todo_provider.dart';
import 'package:todo/Screens/edit_screen.dart';

import '/Provider/theme.dart';

import '/home.dart';

void main() => runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider()
      ),
      ChangeNotifierProvider<TodoProvider>(
        create: (ctx) => TodoProvider(),
      ),],
      child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return 
       MaterialApp(
        initialRoute: Home.homeRoute,
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.theme,
        theme: CurrentTheme.isLightTheme,
        darkTheme: CurrentTheme.isDarkTTheme,
        // routes: {
        //   EditScreen.editscreen: (ctx) => EditScreen()
        // },
        home: Home(),
    );
  }
}
