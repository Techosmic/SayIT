import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';

import '../../style.dart';

class DifficultySelect extends StatelessWidget {
  final Level selectedLevel;

  DifficultySelect({this.selectedLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SayIT'),
      ),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 1,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {
                    selectedLevel.difficulty = 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Adventure'),
                          ),
                          body: Center(
                            child: Text('Level ${selectedLevel.levelNumber} : easy'),
                            ),
                        )
                      ),
                    );
                  },
                  child: Text(
                      'Easy',
                      style: Body1Style
                  ),
                )
            ),
            Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {
                    selectedLevel.difficulty = 2;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Adventure'),
                          ),
                          body: Center(
                            child: Text('Level ${selectedLevel.levelNumber} : medium'),
                            ),
                        )
                      ),
                    );
                  },
                  child: Text(
                      'Medium',
                      style: Body1Style
                  ),
                )
            ),
            Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {
                    selectedLevel.difficulty = 3;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Adventure'),
                          ),
                          body: Center(
                            child: Text('Level ${selectedLevel.levelNumber} : hard'),
                            ),
                        )
                      ),
                    );
                  },
                  child: Text(
                      'Hard',
                      style: Body1Style
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}