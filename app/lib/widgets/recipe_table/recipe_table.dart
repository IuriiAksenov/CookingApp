import 'package:app/models/models.dart';
import 'package:app/widgets/recipe_table/recipe_group.dart';
import 'package:flutter/material.dart';

class RecipeTableWidget extends StatelessWidget {
  final RecipePreviewsTable recipes;
  final bool showEmptyGroups;
  final Function(BuildContext context, int recipeId) onRecipeTap;
  const RecipeTableWidget({
    Key key,
    @required this.recipes,
    @required this.onRecipeTap,
    this.showEmptyGroups = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (showEmptyGroups || recipes.highPopular.recipes.length != 0)
            RecipeGroupWidget(
              group: recipes.highPopular,
              onTap: onRecipeTap,
            ),
          if (showEmptyGroups || recipes.middlePopular.recipes.length != 0)
            RecipeGroupWidget(
              group: recipes.middlePopular,
              onTap: onRecipeTap,
            ),
          if (showEmptyGroups || recipes.lowPopular.recipes.length != 0)
            RecipeGroupWidget(
              group: recipes.lowPopular,
              onTap: onRecipeTap,
            )
        ],
      ),
    );
  }
}
