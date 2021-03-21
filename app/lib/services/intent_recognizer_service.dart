import 'dart:async';

import 'package:app/models/speech_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class IntentRecognizerService with ChangeNotifier {
  Dialogflow _dialogflow;
  AuthGoogle _authGoogle;
  bool _isInitialized = false;
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    _authGoogle = await AuthGoogle(
      fileJson: "assets/app-management-atgm-1c5bd520ea36.json",
    ).build();
    _dialogflow =
        Dialogflow(authGoogle: _authGoogle, language: Language.english);
    _isInitialized = true;
  }

  Future<SpeechIntent> recognieIntent(String speechInWords) async {
    if (speechInWords == null || speechInWords.isEmpty) {
      return null;
    }

    await init();

    final response = await _dialogflow.detectIntent(speechInWords);
    if (response == null || response is List) {
      return null;
    }

    print(response.queryResult.intent.displayName);
    print(response.queryResult.parameters);
    return SpeechIntent(response.queryResult.intent.displayName,
        response.queryResult.parameters);
  }
}
