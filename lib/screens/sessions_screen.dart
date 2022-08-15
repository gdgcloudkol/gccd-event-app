import 'package:ccd2022app/blocs/sessions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  @override
  Widget build(BuildContext context) {
    SessionsGridBloc sb = Provider.of<SessionsGridBloc>(context);

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
            itemCount: sb.day1Sessions.length,
            itemBuilder: (
              context,
              int index,
            ) {
              return SizedBox();
              // return GestureDetector(
              //   onTap: () => {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return SpeakerProfileScreen(
              //               speaker: sb.speakers[index]);
              //         },
              //       ),
              //     )
              //   },
              //   child: SpeakerCard(
              //     id: sb.speakers[index].id,
              //     name: sb.speakers[index].fullName,
              //     profilePicture: sb.speakers[index].profilePicture,
              //     tagLine: sb.speakers[index].tagLine,
              //     socialLinks: sb.speakers[index].links,
              //   ),
              // );
            },
          );
  }
}
