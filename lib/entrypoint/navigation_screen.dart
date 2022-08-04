import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/screens/home_screen.dart';
import 'package:ccd2022app/screens/speakers_screen.dart';
import 'package:ccd2022app/screens/sponsors/partners_screen.dart';
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
    // AuthBloc ab = Provider.of<AuthBloc>(context);

    return WillPopScope(
      ///Custom navigation to transform single page behaviour into multi page stacked nav
      onWillPop: () {
        if (nb.navStack.isEmpty || nb.navStack.length == 1) {
          return Future.value(true);
        } else {
          nb.removeTopIndexFromNavStack();
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: getBody(nb.navIndex),
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            nb.screenNames[nb.navIndex] ?? "",
            style: const TextStyle(
              fontFamily: "GoogleSans",
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: const [
            // if (ab.isLoggedIn && !(ab.profilePicUrl == ""))
            //   CircleAvatar(
            //     foregroundImage: NetworkImage(
            //       ab.profilePicUrl,
            //     ),
            //     radius: 25,
            //     backgroundColor: Colors.white,
            //   ),
            // const SizedBox(
            //   width: 20,
            // ),
          ],
        ),
      ),
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 3:
        return const SpeakersScreen();
      case 4:
        return const PartnersScreen();
      default:
        return const HomeScreen();
    }
  }
}
