import 'package:flutter/material.dart';

class NavigationBloc extends ChangeNotifier {
  int _navIndex = 0;

  int get navIndex => _navIndex;

  List<String> _screenNames = [
    "Home",
  ];

  List<String> get screenNames => _screenNames;

  void changeNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }
}
