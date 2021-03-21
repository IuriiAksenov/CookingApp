import 'package:app/providers/current_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recipe_image.dart';

class RecipeHeader extends StatelessWidget {
  final String imageUrl;
  const RecipeHeader({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 18 / 11,
            child: RecipeImageWidget(imageUrl: imageUrl),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              final navigation = context.read<NavigationProvider>();
              final current = context.read<CurrentRecipeProvider>();
              if (navigation.currentTabIndex == Tabs.current &&
                  !current.hasRecipeInProgress) {
                navigation.popAll();
              } else {
                navigation.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
