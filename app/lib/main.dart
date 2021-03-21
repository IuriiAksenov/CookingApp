import 'package:app/pages/base_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/search/search_page.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/providers/internet_provider.dart';
import 'package:app/providers/opened_provider.dart';
import 'package:app/providers/voice_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/popular_recipes_provider.dart';
import 'package:app/providers/search_provider.dart';
import 'package:app/theme/cooking_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'providers/recipe_provider.dart';

void main() {
  runApp(CookingApp());
}

class CookingApp extends StatelessWidget {
  List<SingleChildWidget> _createProviders() {
    return [
      ChangeNotifierProvider<InternetProvider>(
        create: (context) => InternetProvider(),
      ),
      ChangeNotifierProvider<RecipeProvider>(
        create: (context) => RecipeProvider(context.read<InternetProvider>()),
      ),
      ChangeNotifierProvider<PopularRecipesProvider>(
        create: (context) =>
            PopularRecipesProvider(context.read<RecipeProvider>()),
      ),
      ChangeNotifierProvider<NavigationProvider>(
        create: (context) => NavigationProvider(),
      ),
      ChangeNotifierProvider<SearchProvider>(
        create: (context) => SearchProvider(context.read<RecipeProvider>()),
      ),
      ChangeNotifierProvider<CurrentRecipeProvider>(
        create: (context) => CurrentRecipeProvider(
          context.read<RecipeProvider>(),
          context.read<NavigationProvider>(),
        ),
      ),
      ChangeNotifierProvider<FavoriteRecipesProvider>(
        create: (context) =>
            FavoriteRecipesProvider(context.read<RecipeProvider>()),
      ),
      ChangeNotifierProvider<OpenedRecipesProvider>(
        create: (context) =>
            OpenedRecipesProvider(context.read<RecipeProvider>()),
      ),
      ChangeNotifierProvider<VoiceProvider>(
        create: (context) => VoiceProvider(
          context.read<NavigationProvider>(),
          context.read<CurrentRecipeProvider>(),
          context.read<OpenedRecipesProvider>(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _createProviders(),
      child: MaterialApp(
        title: 'Cooking App',
        debugShowCheckedModeBanner: false,
        theme: CookingAppTheme.cookingAppTheme,
        home: BasePage(),
      ),
    );
  }
}
