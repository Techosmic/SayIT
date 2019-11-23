import 'package:flutter/material.dart';
import '../../api/LevelsDAO.dart';
import '../../model/Level.dart';

import '../../style.dart';
import 'DifficultySelect.dart';

class LevelSelect extends StatefulWidget {
  @override
  LevelSelectState createState() => LevelSelectState();
}

class LevelSelectState extends State<LevelSelect> {
  List<Level> levels = List<Level>();

  @override
  void initState() {
    LevelsDAO.getLevelsListAsync().then((data) =>
        setState(() {
          levels = data;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisis un niveau'),
      ),
      body: GridView.builder(
        itemCount: levels.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: levels[index])),
                    );
                  },
                  child: Text(
                      'Niveau ${levels[index].levelNumber}',
                      style: Body1Style
                  ),
          );
        },
      )
    );
  }
}