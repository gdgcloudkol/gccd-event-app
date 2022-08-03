import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationBloc extends ChangeNotifier {
  ///Nav index variable to control the app navigation
  int _navIndex = 0;

  int get navIndex => _navIndex;

  ///Page names based on nav index
  final Map<int, String> _screenNames = {
    0: "Home",
    1: "Profile",
    3: "Partners",
    4: "Speakers",
    6: "Tell a Friend",
    7: "Terms & Conditions",
    8: "Privacy Policy",
    10: "About Us",
  };

  late GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigationBloc(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  final List<int> _navStack = [0];

  List<int> get navStack => _navStack;

  Map<int, String> get screenNames => _screenNames;

  ///Root level function to change the nav index
  void changeNavIndex(int index) {
    _navIndex = index;
    if (!_navStack.contains(index)) {
      navStack.insert(0, index);
    } else {
      navStack.remove(index);
      navStack.insert(0, index);
    }
    notifyListeners();
  }

  void removeTopIndexFromNavStack() {
    _navStack.remove(_navStack[0]);
    if (kDebugMode) {
      print(navStack);
    }
    _navIndex = _navStack[0];
    notifyListeners();
  }
}
