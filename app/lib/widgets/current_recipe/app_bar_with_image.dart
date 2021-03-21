import 'package:flutter/material.dart';

import '../recipe_image.dart';

class CurrentRecipeHeader extends StatelessWidget {
  final String imageUrl;
  const CurrentRecipeHeader({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 18 / 11,
            child: RecipeImageWidget(imageUrl: imageUrl),
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
