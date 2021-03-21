import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/home/home_recipe_page.dart';
import 'package:app/routes/destination_view.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_route.dart';

class HomeDestinations extends DestinationView {
  @override
  Navigator buildRoutes() {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            final route = context.select<NavigationProvider, CustomRoute>(
                (provider) => provider.homeRoute);
            switch (route.name) {
              case '/recipe':
                return HomeRecipePage(id: route.arguments);
              default:
                return HomePage();
            }
          },
        );
      },
    );
  }
}
