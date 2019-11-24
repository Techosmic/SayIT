import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';
import 'package:sayit/widgets/adventure/DifficultySelect.dart';

import '../../style.dart';

class Story extends StatelessWidget {
  final Level level;

  Story({
    this.level
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('')
      ),
      body: Stack(
        children: < Widget > [
          FlatButton(
            color: mediumColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: level)),
              );
            },
            child: Image.asset('lib/assets/screens/story.png', fit: BoxFit.fill)
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Text(
              "Aujourd'hui, nous allons apprendre à préparer la potion d'invisibilité.\n\nPour commencer, prononce le nom de la potion à voix haute. Ensuite, invoque les différents ingrédients pour les ajouter dans ton chaudron.\n\nAttention, à ta prononciation, si tu te trompe de formule, ta potion tournera en poison !",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ]
      ),
    );
  }
}