import 'dart:io';

import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/license_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthBloc ab = Provider.of<AuthBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);
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
                    children: const [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          "assets/images/Logo.png",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(
                          'CCD 2022',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "GoogleSans",
                            fontSize: 24,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Welcome, ${ab.isLoggedIn ? ab.name.split(" ")[0] : "Guest"}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                // singleDrawerOption(
                //   "Profile",
                //   FontAwesomeIcons.solidUser,
                //   1,
                //   context,
                //   nb,
                //   ab,
                //   tsb,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                if (!ab.isLoggedIn) ...[
                  singleDrawerOption(
                    "Login",
                    FontAwesomeIcons.arrowRightToBracket,
                    2,
                    context,
                    nb,
                    ab,
                    tsb,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                singleDrawerOption(
                  "Partners",
                  FontAwesomeIcons.solidHandshake,
                  3,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Speakers",
                  FontAwesomeIcons.bullhorn,
                  4,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                if (ab.isLoggedIn) ...[
                  singleDrawerOption(
                    "Sign Out",
                    FontAwesomeIcons.arrowRightFromBracket,
                    5,
                    context,
                    nb,
                    ab,
                    tsb,
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
                  6,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Terms & Conditions",
                  FontAwesomeIcons.gavel,
                  7,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Privacy Policy",
                  Icons.privacy_tip_outlined,
                  8,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Licenses",
                  FontAwesomeIcons.fileCode,
                  9,
                  context,
                  nb,
                  ab,
                  tsb,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "About Us",
                  FontAwesomeIcons.circleInfo,
                  10,
                  context,
                  nb,
                  ab,
                  tsb,
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
    TicketStatusBloc tsb,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color:
            nb.navIndex == index ? Colors.green.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontFamily: "GoogleSans",
            fontWeight:
                nb.navIndex == index ? FontWeight.w700 : FontWeight.normal,
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
            tsb,
          );
        },
      ),
    );
  }

  handleDrawerItemTap(
    int index,
    BuildContext context,
    NavigationBloc nb,
    AuthBloc ab,
    TicketStatusBloc tsb,
  ) async {
    if (index != 2) {
      Navigator.pop(context);
    }

    if (index == 2) {
      await ab.loginWithGoogle(context, tsb);
      Navigator.pop(context);
    } else if (index == 5) {
      ab.signOut(context, tsb);
    } else if (index == 6) {
      final bytes = await rootBundle.load('assets/images/Logo.png');
      final list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(list);
      Share.shareFiles(
        [file.path],
        subject: "Cloud Community Days Kolkata 2022",
        text: "Hey! Let's join together for the largest developer conclave "
            "in eastern India - Cloud Community Days Kolkata to"
            " join hundreds of developers and engage with industry experts presenting on cutting edge technology."
            'Hurry, get your pass!\n'
            '\nWebsite: https://gdgcloud.kolkata.dev/ccd2022/\n\n'
            'App: https://play.google.com/store/apps/details?id=com.example.ccd2022app',
      );
    } else if (index == 9) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppLicense(),
        ),
      );
    } else {
      nb.changeNavIndex(index);
    }
  }
}
