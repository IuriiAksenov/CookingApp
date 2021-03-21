import 'package:app/models/recipe_stage.dart';
import 'package:app/providers/recipe_provider.dart';
import 'package:app/providers/voice_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CurrentRecipeProvider with ChangeNotifier {
  int _currentRecipeId;
  List<RecipeStage> _stages;
  int _currentStage = 0;
  final RecipeProvider _recipeProvider;
  bool _isStageVoiceable = false;
  NavigationProvider _navigationProvider;
  static final FlutterTts _flutterTts = FlutterTts();
  CurrentRecipeProvider(this._recipeProvider, this._navigationProvider);

  RecipeStage get stage => _stages == null ? null : _stages[_currentStage];
  bool get isStageVoiceable => _isStageVoiceable;
  bool get hasRecipeInProgress => _currentRecipeId != null;
  int get currentRecipeId => _currentRecipeId;

  Future<void> changeCurrentRecipe(int id) async {
    _currentRecipeId = id;
    _stages = await _recipeProvider.getRecipeStages(id);
    _currentStage = 0;
    notifyListeners();
  }

  void _clearCurrentRecipe() {
    _currentRecipeId = null;
  }

  void setNotVoicable() {
    _isStageVoiceable = false;
    notifyListeners();
  }

  void toNextStage(bool isVoiceable) async {
    await _flutterTts.stop();
    if (_navigationProvider.currentRoute.name == '/stage') {
      _navigationProvider.pop();
    }
    if (_currentStage >= _stages.length - 1) {
      _navigationProvider.pushName(name: '', tab: Tabs.current);
      _clearCurrentRecipe();
    } else {
      _currentStage++;
      _navigationProvider.pushName(
          name: '/stage', tab: Tabs.current, isVoiceable: isVoiceable);
    }
    _isStageVoiceable = isVoiceable;
    notifyListeners();
  }

  void toPreviousStage(bool isVoiceable) async {
    await _flutterTts.stop();
    if (_navigationProvider.currentRoute.name == '/stage') {
      _navigationProvider.pop();
    }
    if (_currentStage <= 0) {
      _navigationProvider.pushName(
          name: '/recipe',
          tab: Tabs.current,
          arguments: _currentRecipeId,
          isVoiceable: isVoiceable);
      _clearCurrentRecipe();
    } else {
      _currentStage--;
      _navigationProvider.pushName(
          name: '/stage', tab: Tabs.current, isVoiceable: isVoiceable);
    }
    _isStageVoiceable = isVoiceable;
    notifyListeners();
  }

  void cancel() {
    toPreviousStage(false);
    notifyListeners();
  }

  void finish() {
    toNextStage(false);
    notifyListeners();
  }
}
