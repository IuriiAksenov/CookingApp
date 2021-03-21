import 'package:flutter/material.dart';

class ScrollableContent extends StatelessWidget {
  final Widget footer;
  final List<Widget> body;
  final double footerHeight;
  const ScrollableContent(
      {Key key, this.body, this.footer, this.footerHeight = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: body,
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: footer,
          ),
        ],
      ),
    );
  }
}
