import 'dart:collection';

import 'package:app/widgets/filter/rounded_text_toogle_button.dart';
import 'package:flutter/material.dart';

class ToogleFilterWidget extends StatefulWidget {
  final String filterTitle;
  final List<String> children;
  final List<bool> selected;
  final Function(List<bool> selected) onChange;
  ToogleFilterWidget(
      {Key key,
      @required this.filterTitle,
      @required this.children,
      @required this.onChange,
      this.selected})
      : super(key: key);

  @override
  _ToogleFilterWidgetState createState() => _ToogleFilterWidgetState();
}

class _ToogleFilterWidgetState extends State<ToogleFilterWidget> {
  List<bool> _selected;
  @override
  void initState() {
    super.initState();
    _selected =
        widget.selected ?? List<bool>.filled(widget.children.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.filterTitle,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [..._buildItems(widget.children).toList()],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItems(List<String> items) {
    var results = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      var itemWidget = Container(
        margin: const EdgeInsets.only(right: 10),
        child: RoundedTextToogleButtonWidget(
          isSelected: _selected[i],
          text: items[i],
          onToogle: (bool isToogled) {
            _selected[i] = isToogled;
            widget.onChange(UnmodifiableListView(_selected));
          },
        ),
      );
      results.add(itemWidget);
    }
    return results;
  }
}
