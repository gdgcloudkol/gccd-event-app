import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(18.0),
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
        getSingleFAQ(
          "What is CCD 2022 Kolkata?",
          "CCD 2022 Kolkata is short form of Cloud Community Days 2022"
              " Kolkata which is among the largest free Cloud developer"
              " conferences in Eastern India.",
        ),
        getSingleFAQ(
          "Where can I find updates related to CCD 2022 Kolkata?",
          " All announcements related to the event are posted to"
              " the GDG Cloud Kolkata chapter mailing list which you can join by joining the chapter"
              " at - GDG Cloud Kolkata Chapter Page. ",
        ),
        getSingleFAQ(
          "How can I attend CCD 2022 Kolkata? How much does it cost?",
          "CCD 2022 Kolkata is a Free event."
              " There are no costs for the ticket to this event. "
              "However, you must apply to be a participant to the event "
              "and only upon a positive review of your application you shall"
              " be allowed to claim a ticket. You can apply to be a participant"
              " by clicking the 'Reserve Your Seat' button on this website's home page.",
        ),
        getSingleFAQ(
          "I want to present a talk/workshop at the conference. What should I do?",
          "You can submit your talk/workshop proposal on our CFP Page."
              " The deadline for submitting CFP for this year’s conference is 12th August,"
              " however, the earlier you submit, more the chances of us reviewing your submission in depth.",
        ),
        getSingleFAQ(
          "Will I be provided travel/stay accommodation to attend the event?",
          "No. There is no provision for covering attendee travel/stay."
              " For speakers, we will decide on case-by-case basis. ",
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget getSingleFAQ(String question, String answer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          title: Text(
            question,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 111, 112, 112),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 20),
              child: Text(
                answer,
                style: const TextStyle(
                  fontFamily: "GoogleSans",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
