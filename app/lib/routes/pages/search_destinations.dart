import 'package:app/pages/search/search_page.dart';
import 'package:app/pages/search/search_recipe_page.dart';
import 'package:app/pages/search/search_results_page.dart';
import 'package:app/routes/destination_view.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_route.dart';

class SearchDestinations extends DestinationView {
  @override
  Navigator buildRoutes() {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            final route = context.select<NavigationProvider, CustomRoute>(
                (provider) => provider.searchRoute);
            switch (route.name) {
              case '/search-results':
                return SearchResultsPage(
                  filter: route.arguments,
                );
              case '/recipe':
                return SearchRecipePage(id: route.arguments);
              default:
                return SearchPage();
            }
          },
        );
      },
    );
  }
}
