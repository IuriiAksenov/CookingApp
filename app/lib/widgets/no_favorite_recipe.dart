import 'package:flutter/material.dart';

class NoFavoriteRecipe extends StatelessWidget {
  const NoFavoriteRecipe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Wrap(
        children: <Widget>[
          Text(
            'You have no favorite recipes, hit ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
          Icon(
            Icons.favorite_border,
            size: 30.0,
            color: Colors.pink,
          ),
          Text(
            'to add them here.',
            softWrap: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          )
        ],
      ),
    );
  }
}
