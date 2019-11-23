import 'package:flutter/material.dart';
import 'package:sayit/style.dart';
import 'package:sayit/widgets/PlayerWidget.dart';
import 'package:sayit/widgets/adventure/LevelSelect.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SayIT'),
      ),
      body: Stack(
        children: < Widget > [
          Image.asset('lib/assets/logo.png'),
          Center(
            child: GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              childAspectRatio: 2.5,
              crossAxisSpacing: 25,
              padding: EdgeInsets.all(75),
              children: < Widget > [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LevelSelect()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.teal, width: 2),
                  ),
                  child: Text(
                    'Aventure',
                    style: Body1Style
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.teal, width: 2),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlayerWidget()),
                    );
                  },
                  child: Text(
                    'Entrainement',
                    style: Body1Style
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}