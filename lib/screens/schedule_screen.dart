import 'package:ccd2022app/blocs/sessions_bloc.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/models/time_slot_model.dart';
import 'package:ccd2022app/widgets/single_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                padding: const EdgeInsets.all(4),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xff3b82f6).withOpacity(0.9),
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
                  color: const Color(0xff3b82f6).withOpacity(0.9),
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
                            if (sgb.day2Slots[index].rooms.length == 1) {
                              return getSingleSession(
                                size,
                                sgb.day2Slots[index],
                                false,
                              );
                            } else {
                              return getSingleSession(
                                size,
                                sgb.day2Slots[index],
                                false,
                                showChangerIcon: true,
                              );
                            }
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
    Size size,
    Timeslot model,
    bool isDay1, {
    bool showChangerIcon = false,
  }) {
    return SingleSession(
      size: size,
      model: model,
      isDay1: isDay1,
      showChangerIcon: showChangerIcon,
    );
  }
}
