import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/speaker_model.dart';

class SpeakerCard extends StatefulWidget {
  const SpeakerCard({
    Key? key,
    required this.name,
    required this.profilePicture,
    required this.tagLine,
    required this.socialLinks,
  }) : super(key: key);

  final String name;
  final String profilePicture;
  final String tagLine;
  final List<Link> socialLinks;

  @override
  State<SpeakerCard> createState() => _SpeakerCardState();
}

class _SpeakerCardState extends State<SpeakerCard> {
  Icon getSocialLink(Link link, BuildContext context) {
    switch (link.title) {
      case "Twitter":
        return const Icon(
          FontAwesomeIcons.twitter,
          color: Color(
            0xFF1DA1F2,
          ),
        );

      case "Facebook":
        return const Icon(
          FontAwesomeIcons.facebook,
          color: Color(
            0xFF3B5998,
          ),
        );
      case "Github":
        return const Icon(
          FontAwesomeIcons.github,
          color: Color(0xFF333F4D),
        );
      case "LinkedIn":
        return const Icon(
          FontAwesomeIcons.linkedin,
          color: Color(0xFF0077B5),
        );
      case "Company Website":
        return const Icon(
          FontAwesomeIcons.globe,
          color: Color(0xFF0077B5),
        );
      case "Instagram":
        return const Icon(
          FontAwesomeIcons.instagram,
          color: Color(0xFFE4405F),
        );
      case "Sessionize":
        return const Icon(
          FontAwesomeIcons.calendar,
          color: Color(0xFF1AB394),
        );
      case "Blog":
        return const Icon(
          FontAwesomeIcons.blogger,
          color: Color(0xFFF57C00),
        );
      default:
        return const Icon(Icons.link);
    }
  }

  Widget getSocialLinks(BuildContext context) {
    if (widget.socialLinks.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.socialLinks.map((link) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                launchUrlString(
                  link.url,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: getSocialLink(link, context),
            ),
          );
        }).toList(),
      ),
    );
  }

  bool isAnimationCompleted = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => isAnimationCompleted = true);
    });
    super.initState();
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
            Stack(
              alignment: Alignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  child: const CircularProgressIndicator(
                    value: 1,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff3d82f8)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  child: const CircularProgressIndicator(
                    value: 0.75,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff2ea94f)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  child: const CircularProgressIndicator(
                    value: 0.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xfff9b923)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  child: const CircularProgressIndicator(
                    value: 0.25,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffe54540)),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: widget.profilePicture,
                  height: MediaQuery.of(context).size.height * 0.12 - 4,
                  width: MediaQuery.of(context).size.height * 0.12 - 5,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
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
              ],
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
                        widget.name,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Tools.multiColors[Random().nextInt(4)],
                        ),
                        duration: const Duration(
                          milliseconds: 700,
                        ),
                        width: !isAnimationCompleted
                            ? 0
                            : MediaQuery.of(context).size.width * 0.2,
                        height: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.tagLine,
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

  Color calculateBackgroundColor({required double value}) {
    if (value > 0.60) {
      return Colors.red;
    } else if (value > 0.30) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
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
