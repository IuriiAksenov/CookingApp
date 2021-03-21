import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String question;
  const QuestionDialog({Key key, @required this.title, @required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: Text(
          question,
          style: TextStyle(fontSize: 20.0),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes')),
          FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No')),
        ],
      ),
    );
  }
}
