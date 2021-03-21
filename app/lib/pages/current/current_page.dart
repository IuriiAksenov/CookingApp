import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/widgets/loading_indicator.dart';
import 'package:app/widgets/no_current_recipe.dart';
import 'package:app/widgets/recipe_table/recipe_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentPage extends StatefulWidget {
  CurrentPage({Key key}) : super(key: key);

  @override
  _CurrentPageState createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  @override
  Widget build(BuildContext context) {
    final recipes = context.select<OpenedRecipesProvider, RecipePreviewsTable>(
        (provider) => provider.recipes);
    final recipesCount = context.select<OpenedRecipesProvider, int>(
        (provider) => provider.recipesCount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently open'),
      ),
      body: recipesCount == 0
          ? NoCurrentRecipe()
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
