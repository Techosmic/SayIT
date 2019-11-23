import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';
import 'package:sayit/style.dart';

class AdventureGame extends StatefulWidget {
  final Level selectedLevel;

  AdventureGame({this.selectedLevel});

  @override
  AdventureGameState createState() => AdventureGameState();
}

class AdventureGameState extends State<AdventureGame> {
  int score = 0;
  int maxScore;

  @override
  Widget build(BuildContext context) {
    maxScore = widget.selectedLevel.words.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
        ),
        body: gameGrid(),
      );
  }

  Widget gameGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            '$score / $maxScore', 
            style: Body1Style,
          )
        ),
        Row(),
        Row(),
        Row(),
        Row(),
        Row(),
      ],
    );
  }
}