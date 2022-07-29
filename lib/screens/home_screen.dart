import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/form_screen.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthBloc ab = Provider.of<AuthBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Cloud Community Days 2022",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "A community organized cloud conference with industry experts presenting on exciting topics!",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Organized by",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "GDG Cloud Kolkata",
                    style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff666666)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Dates: 27th-28th August",
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    fontSize: 20,
                    color: Color(0xff666666)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: getTicketApplyButtonColor(ab, tsb),
                ),
                onPressed: () {
                  if (ab.loginInProgress || tsb.loading) {
                    return;
                  } else if (ab.isLoggedIn) {
                    if (tsb.ticketGranted) {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return const TicketScreen();
                      //     },
                      //   ),
                      // );
                    } else if (tsb.hasApplied) {
                      showSnackBar(context,
                          "You have applied for a ticket. Our team will get back to you soon");
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const FormScreen();
                          },
                        ),
                      );
                    }
                  } else {
                    ab.loginWithGoogle(context,tsb);
                  }
                },
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: ab.loginInProgress || tsb.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            getTicketApplyButtonText(ab, tsb).toUpperCase(),
                            style: const TextStyle(
                              fontFamily: "GoogleSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff16a34a),
                ),
                onPressed: () {
                  launchUrlString(
                    "https://sessionize.com/cloud-community-days",
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Become a Speaker".toUpperCase(),
                      style: const TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  String getTicketApplyButtonText(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.hasApplied) {
        if (tsb.ticketGranted) {
          return "View Ticket";
        } else {
          return "Under Review";
        }
      }
      return "Apply For Ticket";
    } else {
      return "Reserve your seat";
    }
  }

  Color getTicketApplyButtonColor(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.hasApplied) {
        if (tsb.ticketGranted) {
          return const Color(0xffEF4444);
        } else {
          return const Color(0xffeab308);
        }
      }
      return const Color(0xffeab308);
    } else {
      return const Color(0xff3b82f6);
    }
  }
}
