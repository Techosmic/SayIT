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
        primaryColor: Color(0xff005C3E),
        accentColor: Color(0xff112921),
        scaffoldBackgroundColor: mediumColor,

        textTheme: TextTheme(body1: Body1Style)
      ),
      home: Center(
        child: Home(),
      ),
    );
  }
}