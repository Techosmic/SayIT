import 'package:flutter/material.dart';
import 'package:sayit/api/LevelsDAO.dart';
import 'package:sayit/api/SpeechDAO.dart';
import 'package:sayit/model/Level.dart';
import 'package:sayit/widgets/adventure/WinGame.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'LoseGame.dart';

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
class AdventureGame extends StatefulWidget {
  final Level selectedLevel;

  AdventureGame({
    this.selectedLevel
  });

  @override
  AdventureGameState createState() => AdventureGameState();
}

class AdventureGameState extends State < AdventureGame > {
  int essaisRestant = 5;
  int score = 0;
  int maxScore = 10;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  SpeechRecognition _speech;
  String transcription = '';
  String _currentLocale = 'en_US';
  Language selectedLang = languages[1];
  List < Level > levels;
  void captureSpeech() {
    if (essaisRestant > 0) {
      start();
      essaisRestant--;
      if (essaisRestant < 0) {
        stop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoseGame(selectedLevel: levels[widget.selectedLevel.levelNumber]))
        );
      }
    } else {
      stop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoseGame(selectedLevel: levels[widget.selectedLevel.levelNumber]))
      );
    }
  }

  void activateSpeechRecognizer() {
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
      .activate()
      .then((res) => _speechRecognitionAvailable = res);
  }
  void start() => _speech
  .listen(locale: _currentLocale)
  .then((result) => print('_MyAppState.start => result $result'));

  void cancel() =>
  _speech.cancel().then((result) => _isListening = result);

  void stop() => _speech.stop().then((result) {
    setState(() => _isListening = result);
  });

  void onSpeechAvailability(bool result) =>
  setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    setState(
      () =>
      selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() => transcription = text);

  void onRecognitionComplete() => setState(() => onCompleteRecognition());
  void onCompleteRecognition() {
    _isListening = false;
    var word = widget.selectedLevel.words[score];
    if (transcription.contains(word)) {
      essaisRestant = 5;
      score++;
    }
    if (score >= widget.selectedLevel.words.length) {
      score = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WinGame(selectedLevel: levels[widget.selectedLevel.levelNumber]))
      );
    }
  }
  void errorHandler() => activateSpeechRecognizer();
  Future < void > audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  void initState() {
    getLevels();
    audioStart();
  }
  void getLevels() async {
    levels = await LevelsDAO.getLevelsListAsync();
  }
  Future < String > getAudio(String text) async {
    try {
      return await SpeechDAO.fetchAudioUrlAsync(text);
    } catch (e) {
      return "";
    }
  }
  void playSound(String url) {
    try {
      FlutterRadio.stop();
      FlutterRadio.play(url: url);
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    activateSpeechRecognizer();
    maxScore = widget.selectedLevel.words.length;
    var word = widget.selectedLevel.words[score];
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
      ),
      body: Stack(children: < Widget > [
        Image.asset('lib/assets/screens/game.png', fit: BoxFit.fill),
        Center(
          child: Padding(child:
            Column(
              children: [
                Text('Essais restants: $essaisRestant                             Score: $score/$maxScore', style: TextStyle(color: Colors.white), ),//Gne
                Text(widget.selectedLevel.words[score], style: TextStyle(fontSize: 75, color: Colors.white), ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child:
                    FlatButton(
                      onPressed: () {
                        captureSpeech();
                      },
                      child:
                      Icon(
                        Icons.mic,
                        size: 80.0,
                        color: _isListening ? Color.fromRGBO(255, 0, 0, 100) : null,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ),
                ),
                FlatButton(
                  child: Icon(Icons.play_circle_filled),
                  onPressed: () async =>playSound(await getAudio(word)),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(0, 330, 0, 0), ),
        ),
      ], )
    );
  }
}