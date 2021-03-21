import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/repositories/db.dart';
import 'package:app/models/favorite_recipe.dart';
import 'package:flutter/cupertino.dart';

import 'recipe_provider.dart';

class FavoriteRecipesProvider with ChangeNotifier {
  final RecipeProvider _recipeProvider;
  RecipePreviewsTable _favoriteRecipes;
  int _favoriteReipesCount;

  RecipePreviewsTable get recipes => _favoriteRecipes;
  int get recipesCount => _favoriteReipesCount;

  FavoriteRecipesProvider(this._recipeProvider) {
    _updateRecipes();
  }

  Future<bool> isInFavorite(int id) async {
    return await CookingAppDb.isExist(FavoriteRecipe.table, id);
  }

  Future<void> add(int id) async {
    await CookingAppDb.insert(FavoriteRecipe.table, FavoriteRecipe(id: id));
    await _updateRecipes();
  }

  Future<void> delete(int id) async {
    await CookingAppDb.delete(FavoriteRecipe.table, id);
    await _updateRecipes();
  }

  Future _updateRecipes() async {
    final listOfRecipeMap = await CookingAppDb.query(FavoriteRecipe.table);
    _favoriteReipesCount = listOfRecipeMap.length;
    notifyListeners();

    if (_favoriteReipesCount == 0) {
      return;
    }

    final favoriteRecipeIds = listOfRecipeMap
        .map((item) => FavoriteRecipe.fromJson(item).id)
        .toList();
    _favoriteRecipes =
        await _recipeProvider.getFavoriteRecipes(favoriteRecipeIds);
    notifyListeners();
  }
}
