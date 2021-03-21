import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/popular_recipes_provider.dart';
import 'package:app/widgets/loading_indicator.dart';
import 'package:app/widgets/recipe_table/recipe_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final RecipePreviewsTable recipes =
        context.select<PopularRecipesProvider, RecipePreviewsTable>(
            (value) => value.recipes);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: recipes == null
          ? LoadingIndicatorWidget()
          : RecipeTableWidget(
              recipes: recipes,
              onRecipeTap: _onTap,
            ),
    );
  }

  Future<void> _onTap(BuildContext context, int recipeId) async {
    final navigation = context.read<NavigationProvider>();
    navigation.pushName(name: '/recipe', arguments: recipeId);
    await context.read<OpenedRecipesProvider>().add(recipeId);
  }
}
