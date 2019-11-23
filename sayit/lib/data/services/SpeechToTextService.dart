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
class SpeechToTextService {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;
  main(List<String> args) {
    activateSpeechRecognizer();
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
    .listen(locale: selectedLang.code)
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