import 'package:flutter/material.dart';
import 'package:sayit/widgets/adventure/story.dart';
import '../../api/LevelsDAO.dart';
import '../../model/Level.dart';

import '../../style.dart';
import 'DifficultySelect.dart';

class LevelSelect extends StatefulWidget {
  @override
  LevelSelectState createState() => LevelSelectState();
}

class LevelSelectState extends State < LevelSelect > {
  List < Level > levels = List < Level > ();

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
      backgroundColor: mediumColor,
      appBar: AppBar(
        title: Text('Choisis un niveau'),
      ),
      body: GridView.builder(
        itemCount: levels.length,

        padding: EdgeInsets.all(25.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            color: lightColor,
            shape: CircleBorder(side: BorderSide(color: mediumColor, width: 2)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Story(level: levels[index])),
              );
            },
            child: Center(
              child: Text(
                '${levels[index].levelNumber}',
                style: TextStyle(
                  color: darkColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
              ),
            )
          );
        },
      )
    );
  }
}