import 'package:app/providers/current_provider.dart';
import 'package:app/suplemental/helpers.dart';
import 'package:app/widgets/recipe_image.dart';
import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import 'package:provider/provider.dart';

class RecipeCardWidget extends StatelessWidget {
  final RecipePreview recipe;
  final Function(BuildContext context, int recipeId) onTap;
  const RecipeCardWidget({Key key, @required this.recipe, @required this.onTap})
      : assert(recipe != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context, recipe.id),
      child: Container(
        height: 180,
        width: 150,
        margin: const EdgeInsets.only(right: 10.0, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Positioned(
                  child: AspectRatio(
                    aspectRatio: 18 / 11,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: RecipeImageWidget(imageUrl: recipe.imageUrl)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: context.select<CurrentRecipeProvider, int>(
                              (provider) => provider.currentRecipeId) ==
                          recipe.id
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          height: 20,
                          width: 80,
                          child: Text(
                            ' In progress',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox.shrink(),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      recipe.description,
                      style: TextStyle(fontSize: 10),
                      softWrap: true,
                      maxLines: 3,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule, size: 12.0),
                        SizedBox(width: 2.0),
                        //Text(recipe.duration.inMinutes.toString() + ' min'),
                        Text(Helpers.formatDurationString(recipe.duration)),
                        SizedBox(width: 8.0),
                        Icon(Icons.person_outline, size: 14.0),
                        Text(recipe.servingsCount.toString())
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
