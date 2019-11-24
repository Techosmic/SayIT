import 'package:flutter/material.dart';
import 'package:sayit/model/Difficulty.dart';
import 'package:sayit/model/Level.dart';

import '../../style.dart';
import 'AdventureGame.dart';

class DifficultySelect extends StatelessWidget {
  final Level selectedLevel;

  DifficultySelect({
    this.selectedLevel
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisis une difficulté'),
      ),
      body: Stack(children: < Widget > [
        Image.asset('lib/assets/screens/difficulty.png', fit: BoxFit.fill, ),
        GridView.builder(
          itemCount: difficulty.length,
          padding: EdgeInsets.all(125),
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 25, crossAxisSpacing: 10, childAspectRatio: 1.5),
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.teal, width: 2)
              ),
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
      ], )
    );
  }
}