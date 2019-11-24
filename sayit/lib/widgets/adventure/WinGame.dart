import 'package:flutter/material.dart';
import 'package:sayit/api/LevelsDAO.dart';
import 'package:sayit/model/Level.dart';
import 'package:sayit/widgets/Home.dart';

import '../../style.dart';
import 'DifficultySelect.dart';

const languages =
  const [
    const Language('Francais', 'fr_FR'),
      const Language('English', 'en_US'),
        const Language('Pусский', 'ru_RU'),
          const Language('Italiano', 'it_IT'),
            const Language('Español', 'es_ES'),
  ];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}
class WinGame extends StatefulWidget {
  final Level selectedLevel;

  WinGame({
    this.selectedLevel
  });

  @override
  WinGameState createState() => WinGameState();
}

class WinGameState extends State < WinGame > {
  List < Level > levels;

  @override
  void initState() {
    LevelsDAO.getLevelsListAsync().then((result) {
      levels = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
      ),
      body: Stack(children: < Widget > [
        Image.asset('lib/assets/screens/win.png', fit: BoxFit.fill),
        Padding(
          child:
          Column(
            children: [
              Text('Bravo ! Ta potion est réussite! \nN\'hésite pas à retenter cette \nrecette pour te perfectionner.\n\nC\'est l\'heure de ton prochain \ncours!', style: TextStyle(color: Colors.white, fontSize: 30), ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child:
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: levels[widget.selectedLevel.levelNumber])));
                    },
                    child:
                    Text(
                      "Continuer", style: Body1Style,
                    ),
                  ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()));
                },
                child:
                Text(
                  "Retour", style: Body1Style,
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0), ),
      ], )
    );
  }
}