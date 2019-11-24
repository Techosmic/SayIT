import 'package:flutter/material.dart';
import 'package:sayit/model/Difficulty.dart';
import 'package:sayit/model/Level.dart';

import '../../style.dart';
import 'AdventureGame.dart';

const tooltips = {
  0 : "1 seul mot à l'écran à la fois, l'assistant  répète le mot à chaque mauvaise prononciation",
  1 : "1 seul mot à l'écran à la fois, l'assistant ne prononce le mot que lorsque celui-ci apparaît ",
  2 : "Les mots s'enchaînent à l'écran à chaque erreur, l'assistant ne prononce le mot que lorsque celui-ci apparaît",
};

class DifficultySelect extends StatefulWidget {
  final Level selectedLevel;

  DifficultySelect({
    this.selectedLevel
  });

  DifficultySelectState createState() => DifficultySelectState();
}

class DifficultySelectState extends State<DifficultySelect> {
  String _tooltip = "Touche une ampoule pour afficher les règles";
  

  void _displayTooltip(int index) {
    setState(() {
      _tooltip = tooltips[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisis une difficulté'),
      ),
      body: Stack(children: < Widget > [
        Image.asset('lib/assets/screens/difficulty.png', fit: BoxFit.fill, ),
        Column(
            children: < Widget > [
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 50.0, bottom: 30),
                  child: Row(
                    children: < Widget > [
                      ButtonTheme(
                        minWidth: 200,
                        child: FlatButton(
                          color: mediumColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)
                          ),
                          onPressed: () {
                            widget.selectedLevel.difficulty = difficulty[0].toLowerCase();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdventureGame(selectedLevel: widget.selectedLevel)),
                            );
                          },
                          child: Text(
                            '${difficulty[0]}',
                            style: DifficultyButton
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.lightbulb_outline),
                        onPressed: () => _displayTooltip(0),
                      )
                    ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80, bottom: 30.0),
                  child: Row(
                    children: < Widget > [
                      ButtonTheme(
                        minWidth: 200,
                        child: FlatButton(
                          color: mediumColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0)
                          ),
                          onPressed: () {
                            widget.selectedLevel.difficulty = difficulty[1].toLowerCase();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdventureGame(selectedLevel: widget.selectedLevel)),
                            );
                          },
                          child: Text(
                            '${difficulty[1]}',
                            style: DifficultyButton
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.lightbulb_outline),
                        onPressed: () => _displayTooltip(1),
                      )
                    ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Row(
                  children: < Widget > [
                    ButtonTheme(
                      minWidth: 200,
                      child: FlatButton(
                        color: mediumColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0)
                        ),
                        onPressed: () {
                          widget.selectedLevel.difficulty = difficulty[2].toLowerCase();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdventureGame(selectedLevel: widget.selectedLevel)),
                          );
                        },
                        child: Text(
                          '${difficulty[2]}',
                          style: DifficultyButton
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.lightbulb_outline),
                      onPressed: () => _displayTooltip(2),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200, right: 200),
                  child: SizedBox(
                    width: 180,
                    child: Text(
                    "$_tooltip",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: TextStyle(fontSize: 20),
                  ),
                    ),
              )
            ],
          ),
      ], )
    );
  }
}