import 'package:app/main.dart';
import 'package:app/repositories/recipe_api_client.dart';
import 'package:flutter/cupertino.dart';

class InternetProvider with ChangeNotifier {
  InternetProvider() {}

  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  void setNoInternet() {
    _hasInternet = false;
    notifyListeners();
  }
}
