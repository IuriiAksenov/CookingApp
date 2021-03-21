import 'package:app/models/filter.dart';
import 'package:app/models/models.dart';
import 'package:app/models/recipe_stage.dart';
import 'package:app/providers/internet_provider.dart';
import 'package:app/repositories/recipe_api_client.dart';
import 'package:flutter/cupertino.dart';

class RecipeProvider with ChangeNotifier {
  final InternetProvider _internetProvider;

  RecipeProvider(this._internetProvider);

  Future<Recipe> getRecipe(int id) async {
    try {
      return await RecipeApi.getRecipe(id);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<List<RecipeStage>> getRecipeStages(int id) async {
    try {
      return await RecipeApi.getRecipeStages(id);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<RecipePreviewsTable> getPopularRecipes() async {
    try {
      return await RecipeApi.getPopularRecipes();
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<RecipePreviewsTable> getFavoriteRecipes(List<int> recipeIds) async {
    try {
      return await RecipeApi.getFavoriteRecipes(recipeIds);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<RecipePreviewsTable> getOpenedRecipes(List<int> recipeIds) async {
    try {
      return await RecipeApi.getFavoriteRecipes(recipeIds);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<RecipePreviewsTable> searchRecipes({Filter filter}) async {
    try {
      return await RecipeApi.searchRecipes(filter: filter);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }

  Future<int> countFilteredRecipes({Filter filter}) async {
    try {
      return await RecipeApi.countFilteredRecipes(filter: filter);
    } catch (_) {
      _internetProvider.setNoInternet();
      return null;
    }
  }
}
