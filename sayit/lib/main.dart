import 'package:flutter/material.dart';
import 'package:sayit/style.dart';
import 'package:sayit/widgets/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SayIT',
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
        scaffoldBackgroundColor: Colors.teal[50],

        textTheme: TextTheme(body1: Body1Style)
      ),
      home: Center(
        child: Home(),
      ),
    );
  }
}