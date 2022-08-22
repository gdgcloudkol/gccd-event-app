import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/models/speaker_model.dart';
import 'package:ccd2022app/widgets/multiborder_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider
                  .of(context)
                  .auth
                  .getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
     @override
       Widget build(BuildContext context) {
    SpeakersBloc sb = Provider.of<SpeakersBloc>(context);
    AuthBloc ab = Provider.of<AuthBloc>(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ccd_background.png'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Hero(
            tag: sb.speakers[0].id,
            child: MultiBorderImage(
              imageUrl: ab.profilePicUrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ab.name,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sb.speakers[0].tagLine,
              softWrap: true,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'GoogleSans',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: getSocialLinks(sb.speakers[0]),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bio",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        ReadMoreText(
                          sb.speakers[0].bio,
                          trimLines: 10,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...read more',
                          trimExpandedText: 'collapse ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'GoogleSans',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: const Divider(
                        color: Colors.black12,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sessions",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sb.speakers[0].sessions.length,
                          itemBuilder: (context, index) {
                            // print(sb.speakers[0].sessions[index].name);
                            return ListTile(
                              title: Text(
                                sb.speakers[0].sessions[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'GoogleSans',
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSocialLinks(Speaker speaker) {
    if (speaker.links.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: speaker.links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                launchUrlString(
                  link.url,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: getSocialLink(link),
            ),
          );
        }).toList(),
      ),
    );
  }

  Icon getSocialLink(Link link) {
    switch (link.title) {
      case "Twitter":
        return const Icon(FontAwesomeIcons.twitter,
            color: Color(0xFF1DA1F2), size: 30);
      case "Facebook":
        return const Icon(FontAwesomeIcons.facebook,
            color: Color(0xFF3B5998), size: 30);
      case "Github":
        return const Icon(FontAwesomeIcons.github,
            color: Color(0xFF333F4D), size: 30);
      case "LinkedIn":
        return const Icon(FontAwesomeIcons.linkedin,
            color: Color(0xFF0077B5), size: 30);
      case "Company Website":
        return const Icon(FontAwesomeIcons.globe,
            color: Color(0xFF0077B5), size: 30);
      case "Instagram":
        return const Icon(FontAwesomeIcons.instagram,
            color: Color(0xFFE4405F), size: 30);
      case "Sessionize":
        return const Icon(FontAwesomeIcons.calendar,
            color: Color(0xFF1AB394), size: 30);
      case "Blog":
        return const Icon(FontAwesomeIcons.blogger,
            color: Color(0xFFF57C00), size: 30);
      default:
        return const Icon(Icons.link, size: 30);
    }
  }
}
