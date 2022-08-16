import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccd2022app/blocs/sessions_bloc.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/models/sessions_model.dart';
import 'package:ccd2022app/models/speaker_model.dart';
import 'package:ccd2022app/models/time_slot_model.dart';
import 'package:ccd2022app/screens/speaker_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  @override
  Widget build(BuildContext context) {
    SessionsGridBloc sgb = Provider.of<SessionsGridBloc>(context);
    SpeakersBloc sb = Provider.of<SpeakersBloc>(context);
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                padding: const EdgeInsets.all(4),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xff3b82f6).withOpacity(0.6),
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                tabs: [
                  SizedBox(
                    width: size.width / 3.5,
                    height: 55,
                    child: const Tab(
                      child: Text(
                        "Day 1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 3.5,
                    height: 55,
                    child: const Tab(
                      child: Text(
                        "Day 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    ),
                  ),
                ],
                indicator: RectangularIndicator(
                  color: const Color(0xff3b82f6).withOpacity(0.6),
                  bottomLeftRadius: 25,
                  bottomRightRadius: 25,
                  topLeftRadius: 25,
                  topRightRadius: 25,
                  paintingStyle: PaintingStyle.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  sgb.isLoading || sb.isLoading
                      ? SizedBox(
                          height: size.height / 2 + 50,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 80,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: sgb.day1Slots.length,
                          shrinkWrap: true,
                          itemBuilder: (
                            context,
                            int index,
                          ) {
                            return getSingleSession(
                              size,
                              sgb.day1Slots[index],
                              true,
                              sb,
                            );
                          },
                        ),
                  sgb.isLoading || sb.isLoading
                      ? SizedBox(
                          height: size.height / 2 + 50,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 80,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: sgb.day2Slots.length,
                          shrinkWrap: true,
                          itemBuilder: (
                            context,
                            int index,
                          ) {
                            return getSingleSession(
                              size,
                              sgb.day2Slots[index],
                              false,
                              sb,
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSingleSession(
      Size size, Timeslot model, bool isDay1, SpeakersBloc sb) {
    DateFormat format = DateFormat("yyyy-MM-ddTH:m:s");

    SessionsGrid session = model.rooms[0].session;

    DateTime start = format.parse(session.startsAt);
    DateTime end = format.parse(session.endsAt);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("HH:mm").format(start),
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat("HH:mm").format(end),
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "GMT (+05:30)",
                  style: TextStyle(
                    fontFamily: "GoogleSans",
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: size.width - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  if (isDay1)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: const BoxDecoration(
                        color: Color(0xffdcfce7),
                      ),
                      child: Text(
                        session.title == "Lunch"
                            ? "Cafeteria"
                            : "Workshop Hall",
                        style: const TextStyle(
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: const BoxDecoration(
                        color: Color(0xffdcfce7),
                      ),
                      child: Text(
                        session.room,
                        style: const TextStyle(
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    session.title,
                    style: const TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (session.speakers.isEmpty && session.categories.isEmpty)
                    const SizedBox(
                      height: 20,
                    ),
                  if (session.speakers.isNotEmpty) ...[
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Speaker? sp = sb.getSpeaker(session.speakers[0].id);
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
                      child: Chip(
                        backgroundColor:
                            const Color(0xff3b82f6).withOpacity(0.6),
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        avatar: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: CachedNetworkImageProvider(
                              sb.getSpeakerImageUrl(session.speakers[0].id),
                            ),
                          ),
                        ),
                        label: Text(
                          session.speakers[0].name,
                          style: const TextStyle(
                            fontFamily: "GoogleSans",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (session.description != null) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      session.description ?? "",
                      style: const TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 13,
                      ),
                    ),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
