import 'package:app/widgets/filter/rounded_text_button.dart';
import 'package:flutter/material.dart';

class CounterFilterWidget extends StatefulWidget {
  final String filterTitle;
  final int startValue;
  final Function(int counter) onChanged;

  const CounterFilterWidget({
    Key key,
    @required this.filterTitle,
    @required this.onChanged,
    this.startValue = 0,
  }) : super(key: key);

  @override
  _CounterFilterWidgetState createState() => _CounterFilterWidgetState();
}

class _CounterFilterWidgetState extends State<CounterFilterWidget> {
  int _counter;

  void _increment(BuildContext context) {
    setState(() {
      _counter++;
    });
    widget.onChanged(_counter);
  }

  void _decrement(BuildContext context) {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
      widget.onChanged(_counter);
    }
  }

  @override
  void initState() {
    _counter = widget.startValue;
    super.initState();
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
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: RoundedTextButtonWidget(
                  text: '-',
                  onTap: () {
                    _decrement(context);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  '$_counter',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: RoundedTextButtonWidget(
                  text: '+',
                  onTap: () {
                    _increment(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
