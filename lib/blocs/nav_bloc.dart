import 'package:flutter/material.dart';

class NavigationBloc extends ChangeNotifier {

  ///Nav index variable to control the app navigation
  int _navIndex = 0;

  int get navIndex => _navIndex;

  ///Page names based on nav index
  final Map<int,String> _screenNames = {
    0 : "Home",
    1 : "Profile",
    3 : "Sponsors",
    4 : "About Us",
    6: "Tell a Friend",
    7: "Terms & Conditions",
    8: "Privacy Policy",
  };

  Map<int,String> get screenNames => _screenNames;

  ///TODO implement nav stack

  ///Root level function to change the nav index
  void changeNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }
}
