
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.light;

  bool get getTheme => theme == ThemeMode.light;

  void toggleThememode (bool isOn) {
    theme = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class CurrentTheme {
  static final isDarkTTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[700],
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black45
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      elevation: 0.5
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
      foregroundColor: Colors.amber[600],
      backgroundColor: Colors.black
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.amber[600],
      unselectedItemColor: Colors.white38
    ),
    primaryColor: Colors.amber[600],
    colorScheme: const ColorScheme.dark(),
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.amber[600]
  );

  static final isLightTheme = ThemeData(
    primaryColorDark: Colors.amber.shade300,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.grey.shade200,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.amber.shade300
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber[300]
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
      foregroundColor: Colors.white,
      backgroundColor: Colors.amber[300],
      elevation: 0.5
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.amber[300],
      unselectedItemColor: Colors.black38
    ),
    primaryColor: Colors.amber[300],
    colorScheme: const ColorScheme.light(),
  );
}

Color darkListTile = Colors.amber;
Color lightListTile = Colors.white;