import 'package:app/models/models.dart';
import 'package:app/widgets/recipe_table/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RecipeGroupWidget extends StatelessWidget {
  final RecipePreviewsGroup group;
  final Function(BuildContext context, int recipeId) onTap;

  const RecipeGroupWidget({
    Key key,
    @required this.group,
    @required this.onTap,
  })  : assert(group != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              group.recipeGroupType.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...group.recipes
                    .map((value) =>
                        RecipeCardWidget(recipe: value, onTap: onTap))
                    .toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
