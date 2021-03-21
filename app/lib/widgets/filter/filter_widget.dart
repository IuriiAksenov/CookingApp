import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String filterTitle;
  final Widget child;
  const FilterWidget(
      {Key key, @required this.filterTitle, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filterTitle,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
