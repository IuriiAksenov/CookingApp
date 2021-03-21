import 'dart:convert';

import 'package:app/models/filter.dart';
import 'package:app/models/recipe_stage.dart';
import 'package:http/http.dart' as http;

import 'package:app/config/api_urls.dart';
import 'package:app/models/models.dart';

class RecipeApi {
  static final http.Client httpClient = http.Client();

  static Future<RecipePreviewsTable> getPopularRecipes() async {
    try {
      final response = await httpClient
          .get(ApiUrls.toUri(ApiUrls.getPopularRecipes))
          .timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get popular recipes ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to get popular recipes');
      }

      final json = jsonDecode(response.body);
      return RecipePreviewsTable.fromJson(json);
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }

  static Future<RecipePreviewsTable> getFavoriteRecipes(
      List<int> recipeIds) async {
    try {
      final queryParameters = recipeIds.asMap().map<String, String>(
          (key, value) => MapEntry('recipeIds[$key]', value.toString()));
      final uri = ApiUrls.toUri(ApiUrls.getFavoriteRecipes, queryParameters);
      final response = await httpClient.get(uri).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get popular recipes ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to get favorite recipes');
      }

      final json = jsonDecode(response.body);
      return RecipePreviewsTable.fromJson(json);
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }

  static Future<Recipe> getRecipe(int id) async {
    try {
      final uri = ApiUrls.toUri(ApiUrls.getRecipe + "/$id");
      final response = await httpClient.get(uri).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get recipe with id:\'$id\' ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to get recipe with id:\'$id\'');
      }

      final json = jsonDecode(response.body);
      return Recipe.fromJson(json);
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }

  static Future<List<RecipeStage>> getRecipeStages(int id) async {
    try {
      final uri = ApiUrls.toUri(ApiUrls.getRecipe + "/$id/stages");
      final response = await httpClient.get(uri).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get recipe with id:\'$id\' ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to get recipe with id:\'$id\'');
      }

      return recipeStageFromJson(response.body);
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }

  static Future<int> countFilteredRecipes({Filter filter}) async {
    try {
      final uri = ApiUrls.toUri(ApiUrls.searchRecipesCount);
      Map<String, dynamic> map = Map();
      if (filter != null) {
        map = filter.toMap();
      }
      final response = await httpClient.post(
        uri,
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get recipe with ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to filter recipe ');
      }

      final json = jsonDecode(response.body);
      return json;
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }

  static Future<RecipePreviewsTable> searchRecipes({Filter filter}) async {
    try {
      final uri = ApiUrls.toUri(ApiUrls.searchRecipes);
      Map<String, dynamic> map = Map();
      if (filter != null) {
        map = filter.toMap();
      }
      final response = await httpClient.post(
        uri,
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        print(
            'Failed to get popular recipes ${response.statusCode}, ${response.reasonPhrase}');
        throw new Exception('Failed to get favorite recipes');
      }

      final json = jsonDecode(response.body);
      return RecipePreviewsTable.fromJson(json);
    } catch (ex) {
      print("Exception: $ex");
      throw ex;
    }
  }
}
