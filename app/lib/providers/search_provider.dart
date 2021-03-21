import 'dart:async';

import 'package:app/models/filter.dart';
import 'package:app/models/recipe_previews/recipe_previews_table.dart';
import 'package:flutter/cupertino.dart';

import 'recipe_provider.dart';

class SearchProvider with ChangeNotifier {
  final Filter _filter = Filter();
  final RecipeProvider _recipeProvider;
  int _resultsCount = 0;
  RecipePreviewsTable _filteredRecipes;

  SearchProvider(this._recipeProvider) {
    _updateResultsCount();
  }

  Filter get filter => _filter;
  RecipePreviewsTable get recipes => _filteredRecipes;
  int get resultsCount => _resultsCount;

  Future updateFilteredResults() async {
    _filteredRecipes = await _recipeProvider.searchRecipes(filter: filter);
    _resultsCount = _filteredRecipes.totalAmount;
    notifyListeners();
  }

  Future updateQuery(String query) async {
    filter.query = query;
    await _updateResultsCount();
  }

  Future updateSkills(SkillsFilter skillsFilter) async {
    filter.skills = skillsFilter;
    await _updateResultsCount();
  }

  Future updateTablewares(TablewaresFilter tablewaresFilter) async {
    filter.tablewares = tablewaresFilter;
    await _updateResultsCount();
  }

  Future updatePersons(int personasCount) async {
    filter.personas = personasCount;
    await _updateResultsCount();
  }

  Future updateTimes(TimesFilter timesFilter) async {
    filter.times = timesFilter;
    await _updateResultsCount();
  }

  Future updateTypes(TypesFilter typesFilter) async {
    filter.types = typesFilter;
    await _updateResultsCount();
  }

  Future _updateResultsCount() async {
    _resultsCount = await _recipeProvider.countFilteredRecipes(filter: filter);
    notifyListeners();
  }
}
