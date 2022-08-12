import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/blocs/speakers_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/screens/form_screen.dart';
import 'package:ccd2022app/screens/view_ticket_screen.dart';
import 'package:ccd2022app/utils/config.dart';
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
    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    ///Preloading speakers
    Provider.of<SpeakersBloc>(context);

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
                    "assets/images/gdg_logo.png",
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TicketsScreen();
                          },
                        ),
                      );
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
                    ab.loginWithGoogle(context, tsb, nb);
                  }
                },
                child: SizedBox(
                  height: 60,
                  child: ab.loginInProgress || tsb.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: Colors.white,
                          ),
                        )
                      : Center(
                          child: Text(
                            getTicketApplyButtonText(ab, tsb),
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
                  backgroundColor: DateTime.now().isAfter(Config.cfsLastDate)
                      ? const Color(0xff6b7280)
                      : const Color(0xff16a34a),
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
                      DateTime.now().isAfter(Config.cfsLastDate)
                          ? "CFS Closed"
                          : "Become a Speaker".toUpperCase(),
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
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "About Us",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 30,
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
                "GDG Cloud Kolkata is bringing to you the largest Google Cloud developer event in Eastern India. Cloud Community Days Kolkata is the flagship event of GDG Cloud Kolkata, held annually, recollecting the best of the year and setting the stone for the upcoming year. Join us as we bring the best of speakers and help you to put your career on a runway to Google Cloud.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "FAQs",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "What is CCD 2022 Kolkata?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " CCD 2022 Kolkata is short form of Cloud Community Days 2022 Kolkata which is among the largest free Cloud developer conferences in Eastern India.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Where can I find updates related to CCD 2022 Kolkata?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " All announcements related to the event are posted to the GDG Cloud Kolkata chapter mailing list which you can join by joining the chapter at - GDG Cloud Kolkata Chapter Page. ",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "How can I attend CCD 2022 Kolkata? How much does it cost?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " CCD 2022 Kolkata is a Free event. There are no costs for the ticket to this event. However, you must apply to be a participant to the event and only upon a positive review of your application you shall be allowed to claim a ticket. You can apply to be a participant by clicking the 'Reserve Your Seat' button on this website's home page.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "I want to present a talk/workshop at the conference. What should I do?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " You can submit your talk/workshop proposal on our CFP Page. The deadline for submitting CFP for this year’s conference is 12th August, however, the earlier you submit, more the chances of us reviewing your submission in depth.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Will I be provided travel/stay accommodation to attend the event?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " No. There is no provision for covering attendee travel/stay. For speakers, we will decide on case-by-case basis. ",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Code of Conduct",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 30,
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
                "Google is dedicated to providing a harassment-free and inclusive event experience for everyone regardless of gender identity and expression, sexual orientation, disabilities, neurodiversity, physical appearance, body size, ethnicity, nationality, race, age, religion, or other protected category. We do not tolerate harassment of event participants in any form. Google takes violations of our policy seriously and will respond appropriately.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Be excellent to each other",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " We want the event to be an excellent experience for everyone regardless of gender identity and expression, sexual orientation, disabilities, neurodiversity, physical appearance, body size, ethnicity, nationality, race, age, religion, or other protected category. Treat everyone with respect. Participate while acknowledging that everyone deserves to be here -- and each of us has the right to enjoy our experience without fear of harassment, discrimination, or condescension, whether blatant or via micro-aggressions. Jokes shouldn’t demean others. Consider what you are saying and how it would feel if it were said to or about you.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Speak up if you see or hear something.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Harassment is not tolerated, and you are empowered to politely engage when you or others are disrespected. The person making you feel uncomfortable may not be aware of what they are doing, and politely bringing their behavior to their attention is encouraged. If a participant engages in harassing or uncomfortable behavior, the event organizers may take any action they deem appropriate, including warning or expelling the offender from the event with no refund. If you are being harassed or feel uncomfortable, notice that someone else is being harassed, or have any other concerns, please contact a member of the event staff immediately.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                "Practice saying 'Yes and' to each other.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                " It’s a theatre improv technique to build on each other’s ideas. We all benefit when we create together.",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  String getTicketApplyButtonText(AuthBloc ab, TicketStatusBloc tsb) {
    if (ab.isLoggedIn) {
      if (tsb.hasApplied) {
        if (tsb.rejected) {
          return "Rejected";
        } else if (tsb.ticketGranted) {
          return "View Tickets";
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
        if (tsb.rejected) {
          return const Color(0xff6b7280);
        } else if (tsb.ticketGranted) {
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
