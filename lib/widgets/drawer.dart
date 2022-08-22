import 'dart:io';

import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/license_screen.dart';
import 'package:ccd2022app/widgets/social_media_icon.dart';
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
    ReferralBloc rb = Provider.of<ReferralBloc>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: size.height - kToolbarHeight - 30,
          child: SingleChildScrollView(
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
                          "assets/images/gdg_logo.png",
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
                  rb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Speakers",
                  FontAwesomeIcons.bullhorn,
                  3,
                  context,
                  nb,
                  ab,
                  tsb,
                  rb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Schedule",
                  FontAwesomeIcons.chalkboardUser,
                  10,
                  context,
                  nb,
                  ab,
                  tsb,
                  rb,
                ),
                const SizedBox(
                  height: 10,
                ),
                singleDrawerOption(
                  "Partners",
                  FontAwesomeIcons.solidHandshake,
                  4,
                  context,
                  nb,
                  ab,
                  tsb,
                  rb,
                ),
                const SizedBox(
                  height: 10,
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
                    rb,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                if (!ab.isLoggedIn) ...[
                  singleDrawerOption(
                    "Login",
                    FontAwesomeIcons.arrowRightToBracket,
                    2,
                    context,
                    nb,
                    ab,
                    tsb,
                    rb,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                const SizedBox(
                  height: 50,
                ),
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
                  rb,
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
                  rb,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSocialMediaIconButton(
                      "https://twitter.com/gdgcloudkol",
                      const Color(0xff1DA1F2),
                      FontAwesomeIcons.twitter,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildSocialMediaIconButton(
                      "https://www.linkedin.com/company/gdgcloudkol/",
                      const Color(0xff0A66C2),
                      FontAwesomeIcons.linkedin,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildSocialMediaIconButton(
                      "https://facebook.com/gdgcloudkol",
                      const Color(0xff4267B2),
                      FontAwesomeIcons.facebook,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildSocialMediaIconButton(
                      "https://instagram.com/gdgcloudkol",
                      const Color(0xffC13584),
                      FontAwesomeIcons.instagram,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    buildSocialMediaIconButton(
                      "mailto:gdgcloudkol@gmail.com",
                      Colors.red,
                      FontAwesomeIcons.solidEnvelope,
                      size: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (nb.packageInfo != null)
                  Center(
                    child: Text(
                      "v${nb.packageInfo?.version}",
                      style: const TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
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
    ReferralBloc rb, {
    double iconSize = 24,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color:
            nb.navIndex == index ? Colors.green.withOpacity(0.3) : Colors.white,
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
            size: iconSize,
          ),
        ),
        onTap: () {
          handleDrawerItemTap(
            index,
            nb,
            ab,
            tsb,
            rb,
            context,
          );
        },
      ),
    );
  }

  handleDrawerItemTap(
    int index,
    NavigationBloc nb,
    AuthBloc ab,
    TicketStatusBloc tsb,
    ReferralBloc rb,
    BuildContext context,
  ) async {
    if (index != 2) {
      Navigator.pop(context);
    }

    if (index == 2) {
      ab.loginWithGoogle(context, tsb, nb, rb);
      Navigator.pop(context);
    } else if (index == 5) {
      ab.signOut(context, tsb, nb);
    } else if (index == 6) {
      final bytes = await rootBundle.load('assets/images/share.png');
      final list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file =
          await File('${tempDir.path}/Cloud Community Days 2022.jpg').create();
      file.writeAsBytesSync(list);
      Share.shareFiles(
        [file.path],
        subject: "Cloud Community Days Kolkata 2022",
        text: "Hey! Let's join together for the largest developer conclave "
            "in eastern India - Cloud Community Days Kolkata to"
            " join hundreds of developers and engage with industry experts presenting on cutting edge technology. "
            '${ab.isLoggedIn ? "Here is my referral code: ${ab.uid}\n\nHurry, get your pass!\n" : "\n\nHurry, get your pass!\n"}'
            'Download Link: https://play.google.com/store/apps/details?id=com.gdgck.ccd2022',
      );
    } else if (index == 9) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppLicense(
            versionName: nb.packageInfo?.version ?? "v0.0.1-dev",
          ),
        ),
      );
    } else {
      nb.changeNavIndex(index);
    }
  }
}
