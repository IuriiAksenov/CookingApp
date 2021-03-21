import 'package:app/pages/current/current_page.dart';
import 'package:app/pages/current/current_recipe_page.dart';
import 'package:app/pages/current/current_stage_page.dart';
import 'package:app/routes/custom_route.dart';
import 'package:app/routes/destination_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation_provider.dart';

class CurrentDestinations extends DestinationView {
  @override
  Navigator buildRoutes() {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            final route = context.select<NavigationProvider, CustomRoute>(
                (provider) => provider.currentRoute);
            switch (route.name) {
              case '/stage':
                return CurrentStagePage();
              case '/recipe':
                return CurrentRecipePage(
                  id: route.arguments,
                  isVoiceable: route.isVoiceable,
                );
              default:
                return CurrentPage();
            }
          },
        );
      },
    );
  }
}
