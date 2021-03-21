import 'package:app/routes/custom_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum PushPop { push, pop }

class Tabs {
  static const search = 0;
  static const home = 1;
  static const favorite = 2;
  static const current = 3;
}

class NavigationProvider with ChangeNotifier {
  int _currentTabIndex = Tabs.home;
  bool _isVoiceNavigation;

  List<CustomRoute> _searchRoute = [CustomRoute('', null)];
  List<CustomRoute> _homeRoute = [CustomRoute('', null)];
  List<CustomRoute> _favoriteRoute = [CustomRoute('', null)];
  List<CustomRoute> _currentRoute = [CustomRoute('', null)];

  int get currentTabIndex => _currentTabIndex;
  CustomRoute getCurrentTabRoute() {
    switch (_currentTabIndex) {
      case Tabs.search:
        return _searchRoute.last;
      case Tabs.home:
        return _homeRoute.last;
      case Tabs.favorite:
        return _favoriteRoute.last;
      case Tabs.current:
        return _currentRoute.last;
    }
  }

  bool get isVoiceNavigation => _isVoiceNavigation;
  CustomRoute get searchRoute => _searchRoute.last;
  CustomRoute get homeRoute => _homeRoute.last;
  CustomRoute get favoriteRoute => _favoriteRoute.last;
  CustomRoute get currentRoute => _currentRoute.last;

  void _push(
    PushPop pushPop, [
    String routeName,
    Object arguments,
    int tabIndex,
    bool isVoiceNavigation = false,
  ]) {
    _isVoiceNavigation = isVoiceNavigation;
    if (tabIndex != null) _currentTabIndex = tabIndex;

    if (routeName != null) {
      final route = CustomRoute(routeName, arguments, isVoiceNavigation);
      switch (_currentTabIndex) {
        case Tabs.search:
          _searchRoute.add(route);
          break;
        case Tabs.home:
          _homeRoute.add(route);
          break;
        case Tabs.favorite:
          _favoriteRoute.add(route);
          break;
        case Tabs.current:
          _currentRoute.add(route);
          break;
      }
    }
    notifyListeners();
  }

  void pushName(
      {String name, Object arguments, int tab, bool isVoiceable = false}) {
    _push(PushPop.push, name, arguments, tab, isVoiceable);
  }

  void pushNames(
      {@required List<String> names,
      List<Object> arguments,
      int tab,
      List<bool> areVoicable}) {
    if (arguments != null && names.length != arguments.length)
      throw new Exception(
          'Length of name not equal to the length of arguments');

    if (arguments != null && names.length != areVoicable.length)
      throw new Exception(
          'Length of name not equal to the length of areVoicable');

    if (arguments == null) {
      for (var name in names) {
        _push(PushPop.push, name, null, tab);
      }
    } else {
      for (int i = 0; i < names.length; i++) {
        _push(PushPop.push, names[i], arguments[i], tab, areVoicable[i]);
      }
    }
  }

  void pop() {
    switch (_currentTabIndex) {
      case Tabs.search:
        if (_searchRoute.length > 1) _searchRoute.removeLast();
        break;
      case Tabs.home:
        if (_homeRoute.length > 1) _homeRoute.removeLast();
        break;
      case Tabs.favorite:
        if (_favoriteRoute.length > 1) _favoriteRoute.removeLast();
        break;
      case Tabs.current:
        if (_currentRoute.length > 1) _currentRoute.removeLast();
        break;
    }
    notifyListeners();
  }

  void popAll() {
    switch (_currentTabIndex) {
      case Tabs.search:
        if (_searchRoute.length > 1)
          _searchRoute.removeRange(1, _searchRoute.length);
        break;
      case Tabs.home:
        if (_homeRoute.length > 1) _homeRoute.removeRange(1, _homeRoute.length);
        break;
      case Tabs.favorite:
        if (_favoriteRoute.length > 1)
          _favoriteRoute.removeRange(1, _favoriteRoute.length);
        break;
      case Tabs.current:
        if (_currentRoute.length > 1)
          _currentRoute.removeRange(1, _currentRoute.length);
        break;
    }
    notifyListeners();
  }
}
