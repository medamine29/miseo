import 'package:flutter/material.dart';
import 'package:miseo/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor

  static final MyApp instance =
      MyApp._internal(); // applying singleton on App instance

  factory MyApp() =>
      instance; // factory for the class instance --> always return the same instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
