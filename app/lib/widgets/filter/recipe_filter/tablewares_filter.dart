import 'package:app/models/filter.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/toogle_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablewareFilterWidget extends StatefulWidget {
  TablewareFilterWidget({Key key}) : super(key: key);

  @override
  _TablewareFilterWidgetState createState() => _TablewareFilterWidgetState();
}

class _TablewareFilterWidgetState extends State<TablewareFilterWidget> {
  final int _panIndex = 0;
  final int _ovenIndex = 1;
  final int _fryingPanIndex = 2;

  List<bool> _selected;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _selected = [
      provider.filter.tablewares.hasPan,
      provider.filter.tablewares.hasOven,
      provider.filter.tablewares.hasFryingPan,
    ];
  }

  Future _onChange(BuildContext context, List<bool> selcted) async {
    final provider = context.read<SearchProvider>();
    var filter = TablewaresFilter();
    filter.hasPan = selcted[_panIndex];
    filter.hasOven = selcted[_ovenIndex];
    filter.hasFryingPan = selcted[_fryingPanIndex];
    provider.updateTablewares(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToogleFilterWidget(
        filterTitle: "Tableware",
        children: [
          'Pan',
          'Oven',
          'Frying pan',
        ],
        onChange: (List<bool> selcted) async {
          await _onChange(context, selcted);
        },
        selected: _selected,
      ),
    );
  }
}
