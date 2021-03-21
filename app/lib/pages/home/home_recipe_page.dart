import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/widgets/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRecipePage extends StatefulWidget {
  HomeRecipePage({Key key, @required this.id}) : super(key: key);
  final int id;
  @override
  _HomeRecipePageState createState() => _HomeRecipePageState();
}

class _HomeRecipePageState extends State<HomeRecipePage> {
  @override
  void initState() {
    super.initState();
    context.read<OpenedRecipesProvider>().insertRecipe(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return context.select<OpenedRecipesProvider, Recipe>(
                (value) => value.getRecipe(widget.id)) ==
            null
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : RecipeWidget(
            recipe: context.select<OpenedRecipesProvider, Recipe>(
              (value) => value.getRecipe(widget.id),
            ),
            isVoiceable: false,
          );
  }
}
