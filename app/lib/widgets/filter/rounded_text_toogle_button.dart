import 'package:flutter/material.dart';

class RoundedTextToogleButtonWidget extends StatefulWidget {
  final String text;
  final void Function(bool) onToogle;

  final bool isSelected;

  const RoundedTextToogleButtonWidget(
      {Key key,
      @required this.text,
      @required this.onToogle,
      this.isSelected = false})
      : super(key: key);
  @override
  _RoundedTextToogleButtonWidgetState createState() =>
      _RoundedTextToogleButtonWidgetState();
}

class _RoundedTextToogleButtonWidgetState
    extends State<RoundedTextToogleButtonWidget> {
  final Color _unselectedBackgroundColor = Color(0xFFC4C4C4);
  final Color _selectedBackgroundColor = Color(0xFF646964);
  final Color _unselectedTextColor = Colors.black;
  final Color _selectedTextColor = Colors.white;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onToogle(_isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? _selectedBackgroundColor
              : _unselectedBackgroundColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isSelected ? _selectedTextColor : _unselectedTextColor,
            fontSize: 18,
            fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
