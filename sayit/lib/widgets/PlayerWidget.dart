import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_radio/flutter_radio.dart';

class PlayerWidget extends StatefulWidget {
  final String url;

  PlayerWidget({this.url});

  @override
  _PlayerWidgetState createState() => new _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {

  @override
  void initState() {
    super.initState();
    audioStart();
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Audio Plugin Android'),
        ),
        body: new Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.play_circle_filled),
                onPressed: () => FlutterRadio.play(url: widget.url),
              )
            ],
          )
        ),
      );
  }
}