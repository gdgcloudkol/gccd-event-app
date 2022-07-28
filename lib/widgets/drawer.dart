import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthBloc ab = Provider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - kToolbarHeight - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          "assets/images/Logo.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: RichText(
                          text: const TextSpan(
                            text: 'CCD ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "GoogleSans",
                              color: Colors.black,
                              fontSize: 30,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '2',
                                style: TextStyle(
                                  color: Color(0xffea4335),
                                ),
                              ),
                              TextSpan(
                                text: '0',
                                style: TextStyle(
                                  color: Color(0xfffbbc04),
                                ),
                              ),
                              TextSpan(
                                text: '2',
                                style: TextStyle(
                                  color: Color(0xff0f9d58),
                                ),
                              ),
                              TextSpan(
                                text: '2',
                                style: TextStyle(color: Color(0xff4285f4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Welcome, ${ab.isLoggedIn ? ab.name : "Guest"}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Divider(color: Colors.black45),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Home",
                  FontAwesomeIcons.houseChimney,
                  0,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Profile",
                  FontAwesomeIcons.solidUser,
                  1,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!ab.isLoggedIn) ...[
                  singleDrawerOption(
                    "Login",
                    FontAwesomeIcons.arrowRightToBracket,
                    1,
                    context,
                    nb,
                    ab,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                singleDrawerOption(
                  "Sponsors",
                  FontAwesomeIcons.solidHandshake,
                  3,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "About Us",
                  FontAwesomeIcons.circleInfo,
                  4,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (ab.isLoggedIn) ...[
                  singleDrawerOption(
                    "Sign Out",
                    FontAwesomeIcons.arrowRightFromBracket,
                    3,
                    context,
                    nb,
                    ab,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                const Spacer(),
                const Divider(color: Colors.black45),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Tell a Friend",
                  FontAwesomeIcons.shareNodes,
                  5,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Terms & Conditions",
                  FontAwesomeIcons.gavel,
                  4,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Privacy Policy",
                  Icons.privacy_tip_outlined,
                  5,
                  context,
                  nb,
                  ab,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget singleDrawerOption(
    String text,
    IconData icon,
    int index,
    BuildContext context,
    NavigationBloc nb,
    AuthBloc ab,
  ) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontFamily: "GoogleSans",
          fontSize: 18,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          icon,
          color: Colors.black,
          size: 25,
        ),
      ),
      onTap: () {
        handleDrawerItemTap(
          index,
          context,
          nb,
          ab,
        );
      },
    );
  }

  handleDrawerItemTap(
      int index, BuildContext context, NavigationBloc nb, AuthBloc ab) {
    Navigator.pop(context);

    if (index != 3) {
      nb.changeNavIndex(index);
    } else {
      ab.signOut();
    }
  }
}
