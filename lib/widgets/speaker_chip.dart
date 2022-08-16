import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/models/sessions_model.dart';
import 'package:ccd2022app/models/speaker_model.dart';
import 'package:ccd2022app/screens/speaker_profile_screen.dart';
import 'package:flutter/material.dart';

class SpeakerChip extends StatelessWidget {
  const SpeakerChip({Key? key, required this.speaker, required this.sb})
      : super(key: key);

  final SessionSpeaker speaker;
  final SpeakersBloc sb;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Speaker? sp = sb.getSpeaker(speaker.id);
        if (sp != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SpeakerProfileScreen(
                  speaker: sp,
                );
              },
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Chip(
          backgroundColor: const Color(0xff3b82f6).withOpacity(0.7),
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          avatar: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 14,
              backgroundImage: CachedNetworkImageProvider(
                sb.getSpeakerImageUrl(speaker.id),
              ),
            ),
          ),
          label: Text(
            speaker.name,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
