import 'package:app/models/filter.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/toogle_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimesFilterWidget extends StatefulWidget {
  TimesFilterWidget({Key key}) : super(key: key);

  @override
  _TimesFilterWidgetState createState() => _TimesFilterWidgetState();
}

class _TimesFilterWidgetState extends State<TimesFilterWidget> {
  final int _10MinIndex = 0;
  final int _from10To30MinIndex = 1;
  final int _moreThan10MinIndex = 2;

  List<bool> _selected;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _selected = [
      provider.filter.times.is10Min,
      provider.filter.times.isFrom10To30Min,
      provider.filter.times.isMoreThan30Min,
    ];
  }

  Future _onChange(BuildContext context, List<bool> selcted) async {
    final provider = context.read<SearchProvider>();
    var filter = TimesFilter();
    filter.is10Min = selcted[_10MinIndex];
    filter.isFrom10To30Min = selcted[_from10To30MinIndex];
    filter.isMoreThan30Min = selcted[_moreThan10MinIndex];
    provider.updateTimes(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToogleFilterWidget(
        filterTitle: "Time",
        children: [
          '10 min',
          '10-30 min',
          '> 30 min',
        ],
        onChange: (List<bool> selcted) async {
          await _onChange(context, selcted);
        },
        selected: _selected,
      ),
    );
  }
}
