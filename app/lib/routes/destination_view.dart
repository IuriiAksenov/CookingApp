import 'package:flutter/material.dart';

abstract class DestinationView extends StatefulWidget {
  DestinationView({Key key}) : super(key: key);

  @override
  _DestinationViewState createState() => _DestinationViewState();

  Navigator buildRoutes();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return widget.buildRoutes();
  }
}
