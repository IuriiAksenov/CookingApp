// https://github.com/flutter/flutter/issues/65841
// Help with localhost

class ApiUrls {
  static bool _isLocalhost = false;

  static String _productionDomain = 'gohack.2ssupport.ru';
  static String _localhostDomain = '10.0.2.2:15001';
  static String _baseUrl = '/api/v0.1';
  static String _recipeService = '/recipes';
  static String _host = _isLocalhost ? _localhostDomain : _productionDomain;

  static String getPopularRecipes = '$_recipeService/popular';
  static String getFavoriteRecipes = '$_recipeService/favorite';
  static String getRecipe = _recipeService;
  static String getRecipeStages = '$_recipeService/stages';
  static String searchRecipes = '$_recipeService/search';
  static String searchRecipesCount = '$_recipeService/search/count';

  static Uri toUri(String path, [Map<String, String> queryParameters]) {
    return _isLocalhost
        ? Uri.http(_host, path, queryParameters)
        : Uri.https(_host, _baseUrl + path, queryParameters);
  }
}
