import 'package:flutter/material.dart';
import 'package:sayit/model/Level.dart';
import 'package:speech_recognition/speech_recognition.dart';

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
  int score = 0;
  int maxScore;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  SpeechRecognition _speech;

  String transcription = '';

  String _currentLocale = 'en_US';
  Language selectedLang = languages[1];

  @override
  Widget build(BuildContext context) {
    activateSpeechRecognizer();
    maxScore = widget.selectedLevel.words.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode aventure'),
        ),
        body: Center(
          child: Text('Niveau ${widget.selectedLevel.levelNumber} : ${widget.selectedLevel.difficulty} : $transcription'),
          ),
        bottomSheet: RaisedButton(
            onPressed: () {captureSpeech();},
            child: Text(transcription),
          ),
      );
  }
  void captureSpeech() {
    start();
  }
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
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

  void stop() => _speech.stop().then((result)
    => _isListening = result);

  void onSpeechAvailability(bool result) => _speechRecognitionAvailable = result;

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    selectedLang = languages.firstWhere((l) => l.code == locale);
  }

  void onRecognitionStarted() => _isListening = true;

  void onRecognitionResult(String text) => transcription = text;

  void onRecognitionComplete() =>  _isListening = false;

  void errorHandler() => activateSpeechRecognizer();
}