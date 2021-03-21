import 'dart:async';

import 'package:app/models/models.dart';
import 'package:flutter/material.dart';

import 'recipe_provider.dart';

class PopularRecipesProvider with ChangeNotifier {
  RecipePreviewsTable _popularRecipes;
  final RecipeProvider _recipeProvider;

  RecipePreviewsTable get recipes => _popularRecipes;

  PopularRecipesProvider(this._recipeProvider) {
    init();
  }

  Future init() async {
    _popularRecipes = await _recipeProvider.getPopularRecipes();
    notifyListeners();
  }
}
