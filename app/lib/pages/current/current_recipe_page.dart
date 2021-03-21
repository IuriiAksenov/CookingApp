import 'package:app/models/models.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/widgets/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentRecipePage extends StatefulWidget {
  final bool isVoiceable;
  CurrentRecipePage({Key key, @required this.id, @required this.isVoiceable})
      : super(key: key);
  final int id;
  @override
  _CurrentRecipePageState createState() => _CurrentRecipePageState();
}

class _CurrentRecipePageState extends State<CurrentRecipePage> {
  @override
  void initState() {
    context.read<OpenedRecipesProvider>().insertRecipe(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = context.select<OpenedRecipesProvider, Recipe>(
      (value) => value.getRecipe(widget.id),
    );
    return !context.select<OpenedRecipesProvider, bool>(
            (value) => value.isRecipeExist(widget.id))
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : RecipeWidget(
            recipe: recipe,
            isVoiceable: widget.isVoiceable,
          );
  }
}
