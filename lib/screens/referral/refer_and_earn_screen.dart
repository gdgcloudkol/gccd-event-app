import 'dart:io';

import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:ccd2022app/screens/referral/referral_code_input.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:ccd2022app/widgets/indicator_heading.dart';
import 'package:ccd2022app/widgets/referral_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);
  static const String routeName = 'refer_and_earn';

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  /// This function is triggered when the copy icon is pressed
  void _copyToClipboard(String uid) {
    Clipboard.setData(ClipboardData(text: uid)).then(
      (value) => showSnackBar(
        context,
        'Referral code copied to clipboard',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc ab = Provider.of<AuthBloc>(context);
    ReferralBloc rb = Provider.of<ReferralBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    final TextEditingController uidController = TextEditingController(
      text: ab.uid,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Refer and Earn",
          style: TextStyle(
              color: Colors.black87, fontFamily: 'GoogleSans', fontSize: 20),
        ),
        actions: [
          if (!rb.isCountersLoading)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) {
                      return ReferralModal(rb: rb);
                    });
              },
              icon: const Icon(
                FontAwesomeIcons.trophy,
                color: Colors.amber,
              ),
            )
          else
            const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Color(0xff93b5f1),
                ),
              ),
            ),
          SizedBox(
            width: rb.isCountersLoading ? 25 : 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const IndicatorHeading(
              title: "How it works",
              indicatorColor: Colors.blue,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 250,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  infoCircle(
                    "Invitation",
                    "Send your referral code to friends and spread the word.",
                    Icons.mark_chat_read_outlined,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        FontAwesomeIcons.circleArrowRight,
                        color: Color(0xff93b5f1),
                        size: 40,
                      ),
                    ],
                  ),
                  infoCircle(
                    "Registration",
                    "Your friend sign up and submit application for CCD Kolkata 2022.",
                    FontAwesomeIcons.idBadge,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  nextArrow(),
                  infoCircle(
                    "Credit",
                    "Congratulations! You've earned one referral point 🤩",
                    FontAwesomeIcons.circleDollarToSlot,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const IndicatorHeading(
              title: "Invite your friends",
              indicatorColor: Colors.blue,
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                "Invite 25 friends to get an exclusive mystery box.\n\nYour referral code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: uidController,
                readOnly: true,
                style: const TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.copy_all,
                        color: Color(0xff93b5f1),
                      ),
                      onPressed: () {
                        _copyToClipboard(uidController.text);
                      },
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff93b5f1),
                    ))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 180,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.share_outlined),
                onPressed: () async {
                  final bytes =
                      await rootBundle.load('assets/images/share.png');
                  final list = bytes.buffer.asUint8List();

                  final tempDir = await getTemporaryDirectory();
                  final file = await File(
                          '${tempDir.path}/Cloud Community Days 2022.jpg')
                      .create();
                  file.writeAsBytesSync(list);
                  Share.shareFiles(
                    [file.path],
                    subject: "Cloud Community Days Kolkata 2022",
                    text:
                        "Hey! Let's join together for the largest developer conclave "
                        "in eastern India - Cloud Community Days Kolkata to"
                        " join hundreds of developers and engage with industry experts presenting on cutting edge technology. "
                        'Here is my referral code: ${uidController.text}\n\nHurry, get your pass!\n'
                        'Download Link: https://play.google.com/store/apps/details?id=com.gdgck.ccd2022',
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff93b5f1),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                label: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  child: Text(
                    'Share',
                    style: TextStyle(
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (ab.eligibleForReferral)
              ReferralCodeInput(
                ab: ab,
                rb: rb,
                nb: nb,
              ),
            const SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCircle(String title, String description, IconData icon,
      {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(right: isLast ? 25 : 0),
      padding: const EdgeInsets.only(left: 25, right: 0),
      width: 200,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            elevation: 6,
            child: CircleAvatar(
              radius: 50,
              // backgroundColor: const Color(0xfff4f7fe),
              backgroundImage:
                  const AssetImage("assets/images/ccd_background.png"),
              child: Icon(
                icon,
                color: const Color(0xff93b5f1),
                size: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget nextArrow() {
    return Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Icon(
          FontAwesomeIcons.circleArrowRight,
          color: Color(0xff93b5f1),
          size: 40,
        ),
      ],
    );
  }
}
