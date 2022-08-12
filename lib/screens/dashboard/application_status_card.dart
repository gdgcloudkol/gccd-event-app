import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/form_preview_screen.dart';
import 'package:ccd2022app/screens/form_screen.dart';
import 'package:ccd2022app/screens/view_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationStatusCard extends StatelessWidget {
  const ApplicationStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthBloc ab = Provider.of<AuthBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    return Card(
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
                        backgroundColor: getViewApplicationColor(ab, tsb),
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
                          handleViewButtonClick(tsb, context);
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

  void handleViewButtonClick(TicketStatusBloc tsb, BuildContext context) {
    if (tsb.ticketGranted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const TicketsScreen();
          },
        ),
      );
    } else if (tsb.hasApplied) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const FormPreviewScreen();
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
      if (tsb.hasApplied) {
        if (tsb.rejected) {
          return false;
        } else if (tsb.ticketGranted) {
          return true;
        } else {
          //TODO change this to != null once Application Details form has been completed
          return tsb.applicantData == null;
        }
      }else{
        return true;
      }
    }
    return false;
  }
}
