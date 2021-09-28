// TTS
import 'package:flutter_tts/flutter_tts.dart';

class PhraseTTS {
  final FlutterTts flutterTts = FlutterTts();
  Future speak(String phrase, bool english) async {
    String spokenPhrase = phrase;
    if (english) {
      await flutterTts.setLanguage("eng-US");
    } else {
      await flutterTts.setLanguage("fil-PH");
      spokenPhrase = phrase.replaceAll("-i", "-ee");
    }
    await flutterTts.setSpeechRate(0.4);

    await flutterTts.speak(spokenPhrase);
  }
}
