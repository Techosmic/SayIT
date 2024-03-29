import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';

import '../../style.dart';
import 'DifficultySelect.dart';

class CustomLevel extends StatefulWidget {
  @override
  CustomLevelState createState() => CustomLevelState();
}

class CustomLevelState extends State <CustomLevel> {
  Level level = Level (words: List<String>());
  TextEditingController textController = new TextEditingController();
  String notif = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB3E4D4),
      appBar: AppBar(
        title: Text('Entraînement'),
      ),
      body: Center(
        child: GridView.count(crossAxisCount: 1,
              mainAxisSpacing: 15,
              childAspectRatio: 2.5,
              crossAxisSpacing: 25,
              padding: EdgeInsets.all(75),
              children: < Widget > [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Ajoute tes mots ici'
                  ),
                  controller: textController,
                ),
                Text(
                  '$notif',
                  style : TextStyle(color: darkColor)
                ),
                FlatButton(
                  color: mediumColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.teal, width: 2),
                  ),
                  onPressed: () {
                    level.words.add(textController.text);
                    setState(() {
                      notif = '\"${textController.text}\" a été ajouté à ta liste personnelle';
                    });
                    textController.text = "";
                  },
                  child: Text(
                    'Ajouter un mot',
                    style: Body1Style
                  ),
                ),
                FlatButton(
                  color: mediumColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                   onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: level)),
                    );
                  },
                  child: Text(
                    'Choisir la difficulté',
                    style: Body1Style
                  ),
                ),
              ]
        ),
      )
    );
  }
}