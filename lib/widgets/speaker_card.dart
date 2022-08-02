import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/speaker_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpeakerCard extends StatelessWidget {
  const SpeakerCard({
    this.name = "",
    this.profilePicture = "",
    this.tagLine = "",
    this.socialLinks = const [],
    Key? key,
  }) : super(key: key);

  final String name;
  final String profilePicture;
  final String tagLine;
  final List<Link> socialLinks;

  Icon getSocialLink(Link link, BuildContext context) {
    final size = MediaQuery.of(context).size;
    switch (link.title) {
      case "Twitter":
        return const Icon(FontAwesomeIcons.twitter);
      case "Facebook":
        return const Icon(FontAwesomeIcons.facebook);
      case "Github":
        return const Icon(FontAwesomeIcons.github);
      case "LinkedIn":
        return const Icon(FontAwesomeIcons.linkedin);
      case "Company Website":
        return const Icon(FontAwesomeIcons.globe);
      case "Instagram":
        return const Icon(FontAwesomeIcons.instagram);
      case "Sessionize":
        return const Icon(FontAwesomeIcons.calendar);
      case "Blog":
        return const Icon(FontAwesomeIcons.blog);
      default:
        return const Icon(Icons.link);
    }
  }

  Widget getSocialLinks(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (socialLinks.isEmpty) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: InkWell(
            onTap: () {
              launchUrlString(
                link.url,
                mode: LaunchMode.inAppWebView,
              );
            },
            child: getSocialLink(link, context),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              child: CachedNetworkImage(
                imageUrl: profilePicture,
                placeholder: (context, url) => const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 5,
                        color: Tools.multiColors[Random().nextInt(4)],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    tagLine,
                    style: const TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  getSocialLinks(context),
                  // socialActions(context, ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Tools {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static List<Color> multiColors = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue,
  ];
}
