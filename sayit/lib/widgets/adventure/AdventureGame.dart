import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';

class AdventureGame extends StatelessWidget {
  final Level selectedLevel;

  AdventureGame({this.selectedLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
        ),
        body: Center(
          child: Text('Niveau ${selectedLevel.levelNumber} : ${selectedLevel.difficulty}'),
          ),
      );
  }
}