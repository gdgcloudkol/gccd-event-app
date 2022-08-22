import 'package:ccd2022app/models/sessions_model.dart';
import 'package:ccd2022app/widgets/speaker_chip.dart';
import 'package:ccd2022app/widgets/technology_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../blocs/speakers_bloc.dart';
import '../models/time_slot_model.dart';

class SingleSession extends StatefulWidget {
  final Size size;
  final Timeslot model;
  final bool isDay1;
  final bool showChangerIcon;

  const SingleSession({
    Key? key,
    required this.size,
    required this.model,
    required this.isDay1,
    required this.showChangerIcon,
  }) : super(key: key);

  @override
  State<SingleSession> createState() => _SingleSessionState();
}

class _SingleSessionState extends State<SingleSession> {
  final DateFormat format = DateFormat("yyyy-MM-ddTH:m:s");

  SessionsGrid session = SessionsGrid();

  int previousIndex = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ///Change speaker logic for dual view speaker
    if (session.id == "" || (previousIndex != selectedIndex)) {
      session = widget.model.rooms[selectedIndex].session;
    }

    DateTime start = format.parse(session.startsAt);
    DateTime end = format.parse(session.endsAt);
    SpeakersBloc sb = Provider.of<SpeakersBloc>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: widget.size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
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
                        height: 15,
                      ),
                      if (session.categories.isNotEmpty) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Level",
                              style: TextStyle(
                                fontFamily: "GoogleSans",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            getLevels(
                              session.categories[2].categoryItems[0].name,
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: widget.size.width - 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        if (widget.isDay1)
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
                          Row(
                            children: [
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
                                width: 15,
                              ),
                              if (widget.showChangerIcon)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      previousIndex = selectedIndex;
                                      selectedIndex = selectedIndex ^ 1;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.change_circle_outlined,
                                    color: Color(0xff3b82f6),
                                    size: 28,
                                  ),
                                )
                            ],
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
                        if (session.speakers.length == 1) ...[
                          const SizedBox(
                            height: 15,
                          ),
                          SpeakerChip(
                            speaker: session.speakers[0],
                            sb: sb,
                          ),
                        ],
                        if (session.speakers.isEmpty &&
                            session.categories.isEmpty)
                          const SizedBox(
                            height: 20,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (session.speakers.length > 1) ...[
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return SpeakerChip(
                      speaker: session.speakers[i],
                      sb: sb,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: session.speakers.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
            if (session.categories.isNotEmpty) ...[
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                height: 45,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return TechnologyChip(
                      technology: session.categories[1].categoryItems[i].name,
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: session.categories[1].categoryItems.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
            if (session.description != null) ...[
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                  color: const Color(0xff3b82f6).withOpacity(0.9),
                ),
                padding: const EdgeInsets.all(12.0),
                child: ReadMoreText(
                  session.description ?? "",
                  trimLines: 7,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '  Read more',
                  trimExpandedText: '  Collapse ',
                  moreStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  final List<double> levelHeights = [0.8, 1.3, 1.8];

  Widget getLevels(String name) {
    Color color = getColor(name);
    int level = getLevel(name);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        3,
        (index) {
          return Row(
            children: [
              getSingleLevel(levelHeights[index],
                  index > level ? Colors.transparent : color, index > level),
              const SizedBox(
                width: 2,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getSingleLevel(double heightMultiplier, Color color, bool hasBorder) {
    return Container(
      height: 15 * heightMultiplier,
      width: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: hasBorder
            ? Border.all(
                color: Colors.black,
              )
            : null,
      ),
    );
  }

  Color getColor(String name) {
    switch (name) {
      case "Beginner":
        return Colors.green;
      case "Intermediate":
        return Colors.orange;
      case "Advanced":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  int getLevel(String name) {
    switch (name) {
      case "Beginner":
        return 0;
      case "Intermediate":
        return 1;
      case "Advanced":
        return 2;
      default:
        return 4;
    }
  }
}
