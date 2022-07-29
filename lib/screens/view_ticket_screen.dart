import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Tickets",
          style: TextStyle(
            fontFamily: "GoogleSans",
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 35,
          ),
          child: Column(
            children: [
              const Text(
                "Congratulations on making it through hundreds of applications!"
                "We look forward to see you at the Cloud Community Days.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "GoogleSans",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Workshop passes will start rolling out from 5 August."
                "Check here after 5 August for your Workshop pass.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontFamily: "GoogleSans",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.network(tsb.confTicketImageUrl),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xfff3f4f6),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Conference Pass",
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: const [
                        Text("📅   "),
                        Text(
                          "28th August 2022",
                          style: TextStyle(
                            fontFamily: "GoogleSans",
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text("📍   "),
                        SizedBox(
                          width: size.width - 150,
                          child: const Text(
                            "Taal Kutir Convention Center by Taj, Kolkata",
                            style: TextStyle(
                              fontFamily: "GoogleSans",
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: size.width - 72,
                      height: 70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: const Color(0xff2563eb),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          launchUrlString(
                            tsb.confTicketImageUrl,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: const Center(
                          child: Text(
                            "Download",
                            style: TextStyle(
                              fontFamily: "GoogleSans",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildSocialMediaIconButton(
                          "https://www.linkedin.com/company/gdgcloudkol/",
                          const Color(0xff0A66C2),
                          FontAwesomeIcons.linkedin,
                        ),
                        buildSocialMediaIconButton(
                          "https://facebook.com/gdgcloudkol",
                          const Color(0xff4267B2),
                          FontAwesomeIcons.facebook,
                        ),
                        buildSocialMediaIconButton(
                          "https://instagram.com/gdgcloudkol",
                          const Color(0xffC13584),
                          FontAwesomeIcons.instagram,
                        ),
                        buildSocialMediaIconButton(
                          "https://twitter.com/gdgcloudkol",
                          const Color(0xff1DA1F2),
                          FontAwesomeIcons.twitter,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Share the news with your friends, use hashtags #CCDKol and #CloudCommunityDays,"
                      " tag us with @GDGCloudKol and stand a chance to"
                      " win exclusive goodies! 🎉",
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSocialMediaIconButton(
      String launchUrl, Color color, IconData icon) {
    return IconButton(
      onPressed: () {
        launchUrlString(
          launchUrl,
          mode: LaunchMode.externalApplication,
        );
      },
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
