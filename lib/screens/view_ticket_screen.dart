import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/widgets/social_media_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  bool day1Selected = true;

  bool fileLoading = false;

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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 35,
          ),
          child: Column(
            children: [
              const Text(
                "Congratulations on making it through hundreds of applications! "
                "We look forward to see you at the Cloud Community Days.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "GoogleSans",
                ),
              ),
              // const SizedBox(
              //   height: 25,
              // ),
              // const Text(
              //   "Workshop passes will start rolling out from 5 August. "
              //   "Check here after 5 August for your Workshop pass.",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.redAccent,
              //     fontSize: 17,
              //     fontFamily: "GoogleSans",
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              if (tsb.confTicketImageUrl.isNotEmpty &&
                  tsb.workshopTicketImageUrl.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        CircleAvatar(
                          backgroundColor: day1Selected
                              ? const Color(0xff3b82f6)
                              : Colors.transparent,
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (!day1Selected) day1Selected = true;
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.one,
                              size: 20,
                              color: day1Selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CircleAvatar(
                          backgroundColor: !day1Selected
                              ? const Color(0xff3b82f6)
                              : Colors.transparent,
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (day1Selected) day1Selected = false;
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.two,
                              size: 20,
                              color:
                                  !day1Selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CachedNetworkImage(
                      imageUrl: day1Selected
                          ? tsb.workshopTicketImageUrl
                          : tsb.confTicketImageUrl,
                      width: size.width * 0.75,
                      height: size.height * 0.7,
                    ),
                  ],
                )
              else
                CachedNetworkImage(
                  imageUrl: tsb.confTicketImageUrl.isEmpty
                      ? tsb.workshopTicketImageUrl
                      : tsb.confTicketImageUrl,
                ),
              getDayDetails(size, tsb),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> fileFromImageUrl(String imageUrl, bool isConferencePass) async {
    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(
        "${documentDirectory.path}/${isConferencePass ? "conference.png" : "workshop.png"}");

    if (await file.exists()) {
      return file;
    }

    final response = await get(Uri.parse(imageUrl));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  Widget getDayDetails(Size size, TicketStatusBloc tsb) {
    if (tsb.confTicketImageUrl.isEmpty || tsb.workshopTicketImageUrl.isEmpty) {
      if (tsb.confTicketImageUrl.isEmpty) {
        setState(() {
          day1Selected = true;
        });
      } else {
        setState(() {
          day1Selected = false;
        });
      }
    }

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xfff3f4f6),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day1Selected ? "Workshop Pass" : "Conference Pass",
            style: const TextStyle(
              fontSize: 23,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("📅   "),
              Text(
                "${day1Selected ? "27" : "28"}th August 2022",
                style: const TextStyle(
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
                child: Text(
                  day1Selected
                      ? "Government College of Engineering and Ceramic Technology, Kolkata"
                      : "Taal Kutir Convention Center by Taj, Kolkata",
                  style: const TextStyle(
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
                String filePath = "";
                setState(() {
                  fileLoading = true;
                });
                filePath = (await fileFromImageUrl(
                        day1Selected
                            ? tsb.workshopTicketImageUrl
                            : tsb.confTicketImageUrl,
                        !day1Selected))
                    .path;
                setState(() {
                  fileLoading = false;
                });

                OpenFile.open(filePath);
              },
              child: Center(
                child: fileLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
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
    );
  }
}
