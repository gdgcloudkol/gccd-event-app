import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/screens/speaker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/speaker_card.dart';

class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({Key? key}) : super(key: key);

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
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
            physics: const BouncingScrollPhysics(),
            itemCount: sb.speakers.length,
            itemBuilder: (
              context,
              int index,
            ) {
              return GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SpeakerProfileScreen(
                            speaker: sb.speakers[index]);
                      },
                    ),
                  )
                },
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
