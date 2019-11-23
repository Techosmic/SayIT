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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LevelSelect()),
                  );
                  },
                  child: Text(
                      'Mode aventure',
                      style: Body1Style
                  ),
                )
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: RaisedButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlayerWidget()),
                  );
                  },
                  child: Text(
                      'Audio player test',
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