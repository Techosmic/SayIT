import 'package:flutter/material.dart';
import 'package:sayit/data/UnlockedLevelsDao.dart';

import '../../style.dart';
import 'DifficultySelect.dart';

class LevelSelect extends StatefulWidget {
  @override
  LevelSelectState createState() => LevelSelectState();
}

class LevelSelectState extends State<LevelSelect> {
  final unlockedLevels = UnlockedLevelsDao.getLevelList().asMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a level'),
      ),
      body: GridView.builder(
        itemCount: unlockedLevels.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: unlockedLevels[index])),
                    );
                  },
                  child: Text(
                      'Level ${unlockedLevels[index].levelNumber}',
                      style: Body1Style
                  ),
          );
        },
      )
    );
  }
}