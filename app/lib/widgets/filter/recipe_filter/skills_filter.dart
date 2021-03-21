import 'package:app/models/filter.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/toogle_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkillsFilterWidget extends StatefulWidget {
  SkillsFilterWidget({Key key}) : super(key: key);

  @override
  _SkillsFilterWidgetState createState() => _SkillsFilterWidgetState();
}

class _SkillsFilterWidgetState extends State<SkillsFilterWidget> {
  final int _easyIndex = 0;
  final int _mediumIndex = 1;
  final int _hardIndex = 2;

  List<bool> _selected;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _selected = [
      provider.filter.skills.isEasy,
      provider.filter.skills.isMedium,
      provider.filter.skills.isHard,
    ];
  }

  Future _onChange(BuildContext context, List<bool> selcted) async {
    final provider = context.read<SearchProvider>();
    var filter = SkillsFilter();
    filter.isEasy = selcted[_easyIndex];
    filter.isMedium = selcted[_mediumIndex];
    filter.isHard = selcted[_hardIndex];
    provider.updateSkills(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToogleFilterWidget(
        filterTitle: "Skills",
        children: [
          'Easy',
          'Medium',
          'Hard',
        ],
        onChange: (List<bool> selcted) async {
          await _onChange(context, selcted);
        },
        selected: _selected,
      ),
    );
  }
}
