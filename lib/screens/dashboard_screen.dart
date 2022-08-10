import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/form_screen.dart';
import 'package:ccd2022app/screens/view_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthBloc ab = Provider.of<AuthBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Hello,",
              style: TextStyle(
                fontFamily: "GoogleSans",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            Text(
              ab.name,
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          margin: const EdgeInsets.all(20),
                          child: Image.asset("assets/images/ccd_banner.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "CCD Kolkata",
                              style: TextStyle(
                                fontFamily: "GoogleSans",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "2022",
                              style: TextStyle(
                                fontFamily: "GoogleSans",
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Application Status",
                                style: TextStyle(
                                  fontFamily: "GoogleSans",
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Chip(
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                backgroundColor:
                                    getViewApplicationColor(ab, tsb),
                                label: Text(
                                  getTicketStatusChipText(ab, tsb),
                                  style: const TextStyle(
                                    fontFamily: "GoogleSans",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          if (shouldShowViewButton(ab, tsb))
                            Tooltip(
                              message: "View",
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder(),
                                  elevation: 5,
                                ),
                                onPressed: () {
                                  handleViewButtonClick(tsb);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 60,
                                  child: Icon(
                                    Icons.arrow_circle_right,
                                    color: getViewApplicationColor(ab, tsb),
                                    size: 45,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Contests 😎",
              style: TextStyle(
                fontFamily: "GoogleSans",
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                            child: Icon(
                              FontAwesomeIcons.gift,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  "Invite your friends",
                                  style: TextStyle(
                                    fontFamily: "GoogleSans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: const TextSpan(
                                      text: "Get an ",
                                      style: TextStyle(
                                        fontFamily: "GoogleSans",
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'exclusive mystery box ',
                                          style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'for inviting 10 friends.',
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 30,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      nb.changeNavIndex(11);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.boxOpen,
                      color: Colors.black,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Refer and earn",
                        style: TextStyle(
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTicketStatusChipText(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.hasApplied) {
        if (tsb.rejected) {
          return "Rejected";
        } else if (tsb.ticketGranted) {
          return "Ticket Granted";
        } else {
          return "Under Review";
        }
      }
    }
    return "Not Applied";
  }

  Color getViewApplicationColor(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.hasApplied) {
        if (tsb.rejected) {
          return const Color(0xff6b7280);
        } else if (tsb.ticketGranted) {
          return const Color(0xffEF4444);
        } else {
          return const Color(0xffeab308);
        }
      }
    }

    return const Color(0xffeab308);
  }

  void handleViewButtonClick(TicketStatusBloc tsb) {
    if (tsb.ticketGranted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const TicketsScreen();
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const FormScreen();
          },
        ),
      );
    }
  }

  bool shouldShowViewButton(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.rejected) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
