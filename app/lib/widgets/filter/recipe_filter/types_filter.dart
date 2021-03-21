import 'package:app/models/filter.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/toogle_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypesFilterWidget extends StatefulWidget {
  TypesFilterWidget({Key key}) : super(key: key);

  @override
  _TypesFilterWidgetState createState() => _TypesFilterWidgetState();
}

class _TypesFilterWidgetState extends State<TypesFilterWidget> {
  final int _sweetIndex = 0;
  final int _meatIndex = 1;
  final int _veganIndex = 2;

  List<bool> _selected;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _selected = [
      provider.filter.types.isSweet,
      provider.filter.types.isMeat,
      provider.filter.types.isVegan,
    ];
  }

  Future _onChange(BuildContext context, List<bool> selcted) async {
    final provider = context.read<SearchProvider>();
    var filter = TypesFilter();
    filter.isSweet = selcted[_sweetIndex];
    filter.isMeat = selcted[_meatIndex];
    filter.isVegan = selcted[_veganIndex];
    provider.updateTypes(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToogleFilterWidget(
        filterTitle: "Type",
        children: [
          'Sweet',
          'Meat',
          'Vegan',
        ],
        onChange: (List<bool> selcted) async {
          await _onChange(context, selcted);
        },
        selected: _selected,
      ),
    );
  }
}
