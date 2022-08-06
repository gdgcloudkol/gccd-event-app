import 'package:ccd2022app/models/speaker_model.dart';
import 'package:ccd2022app/widgets/multiborder_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SpeakerProfileScreen extends StatelessWidget {
  final Speaker speaker;

  const SpeakerProfileScreen({Key? key, required this.speaker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text(
            "About",
            style: TextStyle(
                color: Colors.black87, fontFamily: 'GoogleSans', fontSize: 20),
          ),
          elevation: 0.0),
      body: Container(
        constraints: const BoxConstraints.expand(),
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
              tag: speaker.id,
              child: MultiBorderImage(
                imageUrl: speaker.profilePicture,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                speaker.fullName,
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
                speaker.tagLine,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'GoogleSans',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: getSocialLinks(speaker),
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
                            speaker.bio,
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
                            itemCount: speaker.sessions.length,
                            itemBuilder: (context, index) {
                              // print(speaker.sessions[index].name);
                              return ListTile(
                                title: Text(
                                  speaker.sessions[index].name,
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
