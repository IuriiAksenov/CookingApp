import 'package:flutter/material.dart';

class CircledListWidget extends StatelessWidget {
  final String title;

  final List<String> items;

  const CircledListWidget({
    Key key,
    @required this.title,
    @required this.items,
  }) : super(key: key);

  List<Widget> buildIngredients(List<String> ingredients) {
    List<Widget> results = [];
    for (var i = 0; i < ingredients.length; i++) {
      var row = Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Text(
                '${i + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              ingredients[i],
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
      );
      results.add(row);
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ...buildIngredients(items),
      ],
    );
  }
}
