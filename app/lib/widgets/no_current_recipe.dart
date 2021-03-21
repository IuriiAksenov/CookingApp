import 'package:flutter/material.dart';

class NoCurrentRecipe extends StatelessWidget {
  const NoCurrentRecipe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        "You have no active recipes",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
