import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/screens/home_screen.dart';
import 'package:ccd2022app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return Scaffold(
      body: getBody(nb.navIndex),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          nb.screenNames[nb.navIndex],
          style: const TextStyle(
            fontFamily: "GoogleSans",
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }
}
