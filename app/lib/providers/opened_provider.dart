import 'package:app/models/models.dart';
import 'package:app/providers/recipe_provider.dart';
import 'package:flutter/cupertino.dart';

class OpenedRecipesProvider with ChangeNotifier {
  List<int> openedRecipeIds = [];
  Map<int, Recipe> openedRecipes = Map();
  final RecipeProvider _recipeProvider;
  RecipePreviewsTable _openedRecipes;

  RecipePreviewsTable get recipes => _openedRecipes;
  bool isRecipeExist(int id) {
    final exist = openedRecipes.containsKey(id);
    if (!exist) insertRecipe(id);
    return exist;
  }

  Recipe getRecipe(int id) {
    return openedRecipes[id];
  }

  int get recipesCount => openedRecipeIds.length;

  OpenedRecipesProvider(this._recipeProvider) {
    _updateRecipes();
  }

  Future<void> add(int id) async {
    if (!openedRecipeIds.contains(id)) {
      openedRecipeIds.add(id);
      await _updateRecipes();
    }
  }

  Future<void> insertRecipe(int id) async {
    if (!openedRecipes.containsKey(id)) {
      final recipe = await _recipeProvider.getRecipe(id);
      openedRecipes.addAll({id: recipe});
      notifyListeners();
    }
  }

  Future<void> _updateRecipes() async {
    if (openedRecipeIds.length == 0) {
      return;
    }

    _openedRecipes = await _recipeProvider.getOpenedRecipes(openedRecipeIds);
    notifyListeners();
  }
}
