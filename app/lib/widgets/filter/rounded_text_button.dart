import 'package:flutter/material.dart';

class RoundedTextButtonWidget extends StatefulWidget {
  final String text;
  final Function onTap;
  RoundedTextButtonWidget({Key key, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  _RoundedTextButtonWidgetState createState() =>
      _RoundedTextButtonWidgetState();
}

class _RoundedTextButtonWidgetState extends State<RoundedTextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFC4C4C4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
