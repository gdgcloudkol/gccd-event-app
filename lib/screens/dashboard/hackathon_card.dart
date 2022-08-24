import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// UI for Hackathon card used in [DashboardScreen]

/// {@category Screens}
/// {@subCategory Dashboard}
class HackathonCard extends StatelessWidget {
  const HackathonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const SizedBox(
          height: 200,
        ),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff0b1127),
              image: const DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://user-images.githubusercontent.com/46371923/183735219-d628d22d-b8a9-40c6-9333-7a0d4d7cc0f1.png",

                ),
              ),
            ),
            width: size.width,
            height: 180,
            // child: const Center(
            //   child: Text(
            //     "Cloud Community Hackday\n\n19th - 21st August",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w700,
            //       fontSize: 20,
            //       fontFamily: "GoogleSans",
            //     ),
            //   ),
            // ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 30,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              primary: Colors.white,
            ),
            onPressed: () {
              launchUrlString(
                "https://github.com/gdgcloudkol/hackday",
                mode: LaunchMode.externalApplication,
              );
            },
            icon: const Icon(
              FontAwesomeIcons.lightbulb,
              color: Colors.black,
            ),
            label: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "View details",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
