import 'package:ccd2022app/blocs/sessions_bloc.dart';
import 'package:ccd2022app/models/sessions_model.dart';
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
    SessionsGridBloc sb = Provider.of<SessionsGridBloc>(context);
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          0,
          25.0,
          0,
          0.0,
        ),
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
                  sb.isLoading
                      ? SizedBox(
                          height: size.height / 2 + 50,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          physics: const BouncingScrollPhysics(),
                          itemCount: sb.day1Sessions.length,
                          shrinkWrap: true,
                          itemBuilder: (
                            context,
                            int index,
                          ) {
                            return getSingleSession(
                              size,
                              sb.day1Sessions[index],
                              true,
                            );
                          },
                        ),
                  sb.isLoading
                      ? SizedBox(
                          height: size.height / 2 + 50,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          physics: const BouncingScrollPhysics(),
                          itemCount: sb.day2Sessions.length,
                          shrinkWrap: true,
                          itemBuilder: (
                            context,
                            int index,
                          ) {
                            return getSingleSession(
                              size,
                              sb.day2Sessions[index],
                              false,
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

  Widget getSingleSession(Size size, SessionsGrid model, bool isDay1) {
    DateFormat format = DateFormat("yyyy-MM-ddTH:m:s");
    DateTime start = format.parse(model.startsAt);
    DateTime end = format.parse(model.endsAt);

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
                    fontSize: 20,
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
                  "GMT (+5:30)",
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
                        model.title == "Lunch" ? "Cafeteria" : "Workshop Hall",
                        style: const TextStyle(
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffdcfce7),
                      ),
                      child: Text(
                        model.room,
                        style: const TextStyle(
                          fontFamily: "GoogleSans",
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (model.description != null) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.description ?? "",
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
