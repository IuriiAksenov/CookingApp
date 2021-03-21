import 'package:app/models/recipe_stage.dart';
import 'package:flutter/material.dart';

import '../recipe_image.dart';

class StagePart extends StatelessWidget {
  final Part stagePart;
  const StagePart({Key key, this.stagePart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: stagePart.stagePartType == 1
          ? Text(
              stagePart.text,
              style: TextStyle(fontSize: 18),
            )
          : AspectRatio(
              aspectRatio: 18 / 11,
              child: RecipeImageWidget(imageUrl: stagePart.url),
            ),
    );
  }
}
