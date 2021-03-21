import 'package:app/pages/favorite/favorite_page.dart';
import 'package:app/pages/favorite/favorite_recipe_page.dart';
import 'package:app/routes/destination_view.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_route.dart';

class FavoriteDestinations extends DestinationView {
  @override
  Navigator buildRoutes() {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            final route = context.select<NavigationProvider, CustomRoute>(
                (provider) => provider.favoriteRoute);
            switch (route.name) {
              case '/recipe':
                return FavoriteRecipePage(id: route.arguments);
              default:
                return FavoritePage();
            }
          },
        );
      },
    );
  }
}
