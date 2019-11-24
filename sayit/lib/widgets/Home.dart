import 'package:flutter/material.dart';
import 'package:sayit/style.dart';
import 'package:sayit/widgets/adventure/LevelSelect.dart';
import 'package:sayit/widgets/adventure/CustomLevel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SayIT'),
      ),
      body: Stack(
        children: < Widget > [
          Image.asset('lib/assets/screens/mode.png', fit: BoxFit.fill, ),
          Padding(
            padding: const EdgeInsets.all(18),
              child: Column(children: < Widget > [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Bonjour Henry !',
                        style: HeaderTextStyle,
                        textAlign: TextAlign.left,
                      )
                    ),
                ),
                Text(
                  "Bienvenue à l'Ecole des Sorciers\n\nSélectionne le mode aventure pour apprendre de nouveaux sorts et  découvrir les secrets de l'école.\n\nOu bien choisis le mode entraînement pour apprendre tes propres sorts ! ",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 8,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160.0, right: 190),
                    child: Column(
                      children: < Widget > [
                        ButtonTheme(
                          minWidth: 1000,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LevelSelect()),
                              );
                            },
                            color: Color(0xff005C3E),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              'AVENTURE',
                              style: Body1Style
                            ),
                          ),
                        ),

                        FlatButton(color: Color(0xff005C3E),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CustomLevel()),
                            );
                          },
                          child: Text(
                            'ENTRAINEMENT',
                            style: Body1Style
                          ),
                        ),
                      ],
                    ),
                ),
              ], ),
          )
        ],
      )
    );
  }
}