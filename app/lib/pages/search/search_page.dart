import 'dart:async';

import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/widgets/filter/recipe_filter/personas_filter.dart';
import 'package:app/widgets/filter/recipe_filter/skills_filter.dart';
import 'package:app/widgets/filter/recipe_filter/tablewares_filter.dart';
import 'package:app/widgets/filter/recipe_filter/times_filter.dart';
import 'package:app/widgets/filter/recipe_filter/types_filter.dart';
import 'package:app/widgets/scrollable_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchQuery;
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _searchQuery = TextEditingController(text: provider.filter.query);
    _searchQuery.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    var searchProvider = context.read<SearchProvider>();
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await searchProvider.updateQuery(_searchQuery.text);
    });
  }

  Future _showRecipes(BuildContext context) async {
    final provider = context.read<SearchProvider>();
    provider.updateFilteredResults();
    final navigation = context.read<NavigationProvider>();
    navigation.pushName(name: '/search-results');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: ScrollableContent(
          body: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 35,
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(12, 118, 118, 128),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        hintText: 'Search',
                      ),
                      controller: _searchQuery,
                    ),
                  ),
                  SkillsFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  TablewareFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  PersonasFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  TimesFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  TypesFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RaisedButton(
              color: Color(0xFFF57600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                await _showRecipes(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Show ${context.watch<SearchProvider>().resultsCount} recipes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }
}
