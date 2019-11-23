import 'package:flutter/material.dart';
import 'package:sayit/model/Difficulty.dart';
import 'package:sayit/model/Level.dart';

import '../../style.dart';
import 'AdventureGame.dart';

class DifficultySelect extends StatelessWidget {
  final Level selectedLevel;

  DifficultySelect({this.selectedLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisis une difficulté'),
      ),
      body: GridView.builder(
        itemCount: difficulty.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
                  onPressed: () {
                    selectedLevel.difficulty = difficulty[index].toLowerCase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdventureGame(selectedLevel: selectedLevel)),
                    );
                  },
                  child: Text(
                      '${difficulty[index]}',
                      style: Body1Style
                  ),
          );
        },
      )
    );
  }
}