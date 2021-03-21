import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  static final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  final String _language = "en-US";
  final double _volume = 1.0;
  final double _pitch = 1.0;
  final double _rate = 0.5;

  Future<void> _init() async {
    if (_isInitialized) {
      return;
    }
    await _flutterTts.setLanguage(_language);
    await _flutterTts.setVolume(_volume);
    await _flutterTts.setSpeechRate(_rate);
    await _flutterTts.setPitch(_pitch);
    _isInitialized = true;
  }

  Future<void> speakText(String text) async {
    await _init();
    _flutterTts.stop();

    if (text != null && text.isNotEmpty) {
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.speak(text);
    }
  }

  Future<void> stopSpeak() async {
    await _init();
    await _flutterTts.stop();
  }
}
