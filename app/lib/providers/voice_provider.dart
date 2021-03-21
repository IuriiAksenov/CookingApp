import 'package:app/models/speech_intent.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/services/intent_recognizer_service.dart';
import 'package:app/services/text_to_speech_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'opened_provider.dart';

enum VoiceRecipeStage { ingredients, start }

class VoiceProvider with ChangeNotifier {
  static final SpeechToText _speech = SpeechToText();
  static final IntentRecognizerService _recognizerService =
      IntentRecognizerService();
  static final TextToSpeechService _textToSpeechService = TextToSpeechService();
  NavigationProvider _navigationProvider;
  CurrentRecipeProvider _currentRecipeProvider;
  OpenedRecipesProvider _openedRecipesProvider;
  VoiceRecipeStage stage = VoiceRecipeStage.ingredients;

  String _lastWords = '';
  bool _isListening = false;
  bool _isRecognized = false;
  bool _isInitialized = false;

  bool get isListening => _isListening;

  VoiceProvider(
      NavigationProvider navigationProvider,
      CurrentRecipeProvider currentRecipeProvider,
      OpenedRecipesProvider openedRecipesProvider) {
    _navigationProvider = navigationProvider;
    _currentRecipeProvider = currentRecipeProvider;
    _openedRecipesProvider = openedRecipesProvider;
  }

  Future<void> cannotRecognizeYou() async {
    await _textToSpeechService.speakText('I' 'm not able to recognize you.');
  }

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    _isInitialized = await _speech.initialize(
      onStatus: (_) async {
        _isListening = _speech.isListening;
        notifyListeners();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  Future<void> startListening() async {
    await init();
    await _speech.listen(
        onResult: _onResult,
        listenFor: Duration(seconds: 20),
        localeId: "en_US",
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  Future<void> stopListening() async {
    await init();
    await _speech.stop();
  }

  Future<void> _onResult(SpeechRecognitionResult result) async {
    _isRecognized = result.finalResult;
    notifyListeners();
    _lastWords = result.recognizedWords;
    if (result.finalResult) {
      print('${result.recognizedWords} - ${result.finalResult}');
      _lastWords = _lastWords.replaceAll('\'', '');
      final intent = await _recognizerService.recognieIntent(_lastWords);
      await _manageIntent(intent);
      // print(intent.name + '   ');

      // await _currentRecipeProvider.changeCurrentRecipe(24);
      // _navigationProvider.pushNames(
      //     names: ['/recipe', '/stage'],
      //     tab: Tabs.current,
      //     areVoicable: [false, true]);
    }
    // result.recognizedWords
  }

  Future<void> _manageIntent(SpeechIntent intent) async {
    switch (intent.name) {
      case 'recipe.show':
        await _showRecipe(intent);
        break;
      case 'recipe.move':
        _moveStage(intent);
        break;
      case 'finish':
        _finish();
        break;
      case 'start':
        await _start();
        break;
      case 'cancel':
        _cancel();
        break;
      case 'answer.no':
        await yesNoAnswer(false);
        break;
      case 'answer.yes':
        await yesNoAnswer(true);
        break;
      default:
        await cannotRecognizeYou();
    }
  }

  Future<void> _moveStage(SpeechIntent intent) async {
    if (!_currentRecipeProvider.hasRecipeInProgress) {
      await _textToSpeechService.speakText('No any recipe is in progress.');
      return;
    }
    final direction = intent.parameters['direction'];
    if (direction == 'next') {
      _currentRecipeProvider.toNextStage(true);
    } else if (direction == 'previous') {
      _currentRecipeProvider.toPreviousStage(true);
    } else {
      await cannotRecognizeYou();
    }
  }

  Future<void> _startCooking(int recipeId, [bool cancelVoice = false]) async {
    await _currentRecipeProvider.changeCurrentRecipe(recipeId);

    if (_navigationProvider.currentTabIndex == Tabs.current) {
      _navigationProvider.pushName(
          name: '/stage',
          tab: Tabs.current,
          isVoiceable: cancelVoice ? false : true);
    } else {
      _navigationProvider.pushNames(
          names: ['/recipe', '/stage'],
          tab: Tabs.current,
          areVoicable: [false, cancelVoice ? false : true],
          arguments: [recipeId, null]);
    }
  }

  Future<void> yesNoAnswer(bool isYes) async {
    final voiceableRecipe = _openedRecipesProvider
        .openedRecipes[_navigationProvider.currentRoute.arguments];
    if (stage == VoiceRecipeStage.ingredients) {
      if (!isYes) {
        final buffer = StringBuffer();
        buffer.writeAll(voiceableRecipe.ingredients, '\n');
        await _textToSpeechService.speakText(buffer.toString());
      }
      stage = VoiceRecipeStage.start;
      await _textToSpeechService.speakText('Can we start cooking?');
    } else if (stage == VoiceRecipeStage.start) {
      await _startCooking(voiceableRecipe.id);
      stage = VoiceRecipeStage.ingredients;
    }
  }

  Future<void> _showRecipe(SpeechIntent intent) async {
    final recipeName = intent.parameters['recipe-name'];
    if (recipeName == null || !recipes.containsKey(recipeName)) {
      await _textToSpeechService.speakText('Sorry, I can\'t find the recipe');
      return;
    }
    final recipeId = recipes[recipeName];

    await _openedRecipesProvider.add(recipeId);
    if (_navigationProvider.currentRoute.name == '/recipe') {
      _navigationProvider.pop();
    }
    _navigationProvider.pushName(
        name: '/recipe',
        tab: Tabs.current,
        isVoiceable: true,
        arguments: recipeId);
  }

  Future<void> _start() async {
    final voiceableRecipe = _openedRecipesProvider
        .openedRecipes[_navigationProvider.getCurrentTabRoute().arguments];
    if (voiceableRecipe == null || voiceableRecipe.id == null) {
      await _textToSpeechService
          .speakText('Sorry, I' 'm not able to start nothing.');
      return;
    }
    await _startCooking(voiceableRecipe.id);
  }

  void _finish() {
    _currentRecipeProvider.finish();
  }

  void _cancel() {
    _currentRecipeProvider.cancel();
  }

  Map<String, int> recipes = {
    'scrambled eggs': 11,
    'caesar salad': 21,
    'uzbek pilaf': 31
  };
}
