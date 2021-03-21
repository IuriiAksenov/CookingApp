import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/counter_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonasFilterWidget extends StatefulWidget {
  const PersonasFilterWidget({Key key}) : super(key: key);

  @override
  _PersonasFilterWidgetState createState() => _PersonasFilterWidgetState();
}

class _PersonasFilterWidgetState extends State<PersonasFilterWidget> {
  int _personas = 0;
  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _personas = provider.filter.personas;
  }

  void _onChange(BuildContext context, int counter) {
    final provider = context.read<SearchProvider>();
    provider.updatePersons(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CounterFilterWidget(
        filterTitle: 'Personas',
        onChanged: (int counter) {
          _onChange(context, counter);
        },
        startValue: _personas,
      ),
    );
  }
}
