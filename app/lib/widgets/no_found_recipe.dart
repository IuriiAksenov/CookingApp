import 'package:flutter/material.dart';

class NoFoundRecipe extends StatelessWidget {
  const NoFoundRecipe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        "No recipes found",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
