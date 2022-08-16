import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavigationBloc extends ChangeNotifier {
  ///Nav index variable to control the app navigation
  int _navIndex = 0;

  int get navIndex => _navIndex;

  ///Page names based on nav index
  final Map<int, String> _screenNames = {
    0: "Home",
    1: "Profile",
    3: "Speakers",
    4: "Partners",
    6: "Tell a Friend",
    7: "Dashboard",
    10: "Sessions",
  };

  late GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;

  NavigationBloc(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    initPackageInfo();
  }

  initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
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
    _navIndex = _navStack[0];
    notifyListeners();
  }

  void removeIndexFromNavStack(index) {
    bool isIndexTop = false;
    if (index == _navStack[0]) {
      isIndexTop = true;
    }
    _navStack.remove(index);
    if (isIndexTop) {
      _navIndex = _navStack[0];
    }
    notifyListeners();
  }
}
