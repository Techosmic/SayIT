import 'package:flutter/material.dart';
import 'package:sayit/api/LevelsDAO.dart';
import 'package:sayit/model/Level.dart';
import 'package:speech_recognition/speech_recognition.dart';

import 'DifficultySelect.dart';

const languages = const [
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

  AdventureGame({this.selectedLevel});

  @override
  AdventureGameState createState() => AdventureGameState();
}

class AdventureGameState extends State<AdventureGame> {
  int essaisRestant = 5;
  int score = 0;
  int maxScore = 10;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  SpeechRecognition _speech;
  String transcription = '';
  String winorlose = "";
  String _currentLocale = 'en_US';
  Language selectedLang = languages[1];
  List<Level> levels;
  void captureSpeech() {
    if(essaisRestant > 0) {
      start();
      essaisRestant--;
      if(essaisRestant == 0){
        winorlose = "You lose!";
      }
    } else {
      winorlose = "You lose!";
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

  void stop() => _speech.stop().then((result){
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
    if(transcription.contains(word)) {
      score++;
    }
    if(score >= widget.selectedLevel.words.length) {
      score = 0;
      winorlose = "You win!";
    }
  }
  void errorHandler() => activateSpeechRecognizer();
  void initState() {
    getLevels();
  }
  void getLevels() async {
    levels = await LevelsDAO.getLevelsListAsync();
  }
  @override
  Widget build(BuildContext context) {
    activateSpeechRecognizer();
    maxScore = widget.selectedLevel.words.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
        ),
        body: Center(
          child: Column(
              children: [
                Text('Essais restants: $essaisRestant     Score: $score/$maxScore'),
                Text(widget.selectedLevel.words[score]),
                RaisedButton(
                  onPressed: () {_isListening ? 
                  null : winorlose.contains("win") ? 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DifficultySelect(selectedLevel: levels[widget.selectedLevel.levelNumber] )))
                  : captureSpeech();},
                  color: _isListening ? Color.fromRGBO(255, 0, 0, 100) : winorlose.contains("win") ? Color.fromRGBO(0, 255, 0, 100) : null,
                  child: Text(winorlose.contains("win")? "Aller au niveau suivant" :"enregistre ta prononciation"),
                ),
                Text("$winorlose"),
              ],
              )
          ),
      );
  }
}