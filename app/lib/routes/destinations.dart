import 'package:app/routes/pages/current_destinations.dart';
import 'package:app/routes/pages/favorite_destinations.dart';
import 'package:app/routes/pages/home_destinations.dart';
import 'package:app/routes/pages/search_destinations.dart';
import 'package:app/routes/destination.dart';
import 'package:app/routes/destination_view.dart';
import 'package:flutter/material.dart';

abstract class Destinations {
  static const List<Destination> allDestinations = <Destination>[
    Destination("Search", Icons.search),
    Destination("Home", Icons.home),
    Destination("Favorite", Icons.favorite_border, color: Colors.red),
    Destination("Current", Icons.menu),
  ];

  static DestinationView buildDestinationView(Destination destination) {
    switch (destination.title) {
      case "Search":
        return SearchDestinations();
      case "Favorite":
        return FavoriteDestinations();
      case "Current":
        return CurrentDestinations();
      default:
        return HomeDestinations();
    }
  }
}
