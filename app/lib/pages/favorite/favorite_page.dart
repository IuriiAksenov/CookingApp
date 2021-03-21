import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/widgets/loading_indicator.dart';
import 'package:app/widgets/no_favorite_recipe.dart';
import 'package:app/widgets/recipe_table/recipe_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final recipes =
        context.select<FavoriteRecipesProvider, RecipePreviewsTable>(
            (provider) => provider.recipes);
    final recipesCount = context.select<FavoriteRecipesProvider, int>(
        (provider) => provider.recipesCount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: recipesCount == 0
          ? NoFavoriteRecipe()
          : recipes == null
              ? LoadingIndicatorWidget()
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
