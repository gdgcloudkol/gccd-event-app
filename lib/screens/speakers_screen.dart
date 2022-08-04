import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/speaker_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/speaker_model.dart';

class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({Key? key}) : super(key: key);

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
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

  Widget getSocialLinks(BuildContext context, Speaker speaker) {
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
              child: getSocialLink(link, context),
            ),
          );
        }).toList(),
      ),
    );
  }

  _showFullModal(context, speaker) {
    showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      barrierLabel: "About",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
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
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20),
              ),
              elevation: 0.0),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Hero(
                tag: speaker.id,
                child: Stack(
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
                      imageUrl: speaker.profilePicture,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  speaker.fullName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Overpass',
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
                    fontFamily: 'Overpass',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: getSocialLinks(context, speaker),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Overpass',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Text(
                      speaker.bio,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Overpass',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SpeakersBloc sb = Provider.of<SpeakersBloc>(context);

    return sb.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          )
        : ListView.builder(
            itemCount: sb.speakers.length,
            itemBuilder: (
              context,
              int index,
            ) {
              return GestureDetector(
                onTap: () => {_showFullModal(context, sb.speakers[index])},
                child: SpeakerCard(
                  id: sb.speakers[index].id,
                  name: sb.speakers[index].fullName,
                  profilePicture: sb.speakers[index].profilePicture,
                  tagLine: sb.speakers[index].tagLine,
                  socialLinks: sb.speakers[index].links,
                ),
              );
            },
          );
  }
}
