import 'package:app/models/filter.dart';
import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/loading_indicator.dart';
import 'package:app/widgets/no_found_recipe.dart';
import 'package:app/widgets/recipe_table/recipe_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatefulWidget {
  SearchResultsPage({Key key, this.filter}) : super(key: key);

  final Filter filter;

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    final RecipePreviewsTable recipes = context
        .select<SearchProvider, RecipePreviewsTable>((value) => value.recipes);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            final NavigationProvider navigationProvider =
                context.read<NavigationProvider>();
            navigationProvider.pop();
          },
        ),
        title: Text('Search'),
      ),
      body: recipes == null
          ? LoadingIndicatorWidget()
          : recipes.totalAmount == 0
              ? NoFoundRecipe()
              : RecipeTableWidget(
                  recipes: recipes,
                  onRecipeTap: _onTap,
                  showEmptyGroups: false,
                ),
    );
  }

  Future<void> _onTap(BuildContext context, int recipeId) async {
    final navigation = context.read<NavigationProvider>();
    navigation.pushName(name: '/recipe', arguments: recipeId);
    await context.read<OpenedRecipesProvider>().add(recipeId);
  }
}
