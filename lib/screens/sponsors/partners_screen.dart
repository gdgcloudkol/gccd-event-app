import 'package:ccd2022app/models/community_partners_model.dart';
import 'package:ccd2022app/screens/sponsors/cards/sliding_card_view_state.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/widgets/indicator_heading.dart';
import 'package:ccd2022app/widgets/sponsor_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({Key? key}) : super(key: key);

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  CommunityPartnersModel currentModel = Config.communityPartners[0];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
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
            const IndicatorHeading(
              title: "Sponsors",
              indicatorColor: Colors.green,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Extensive partner network to fuel brand growth",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...List<Widget>.generate(
              Config.sponsorsLinks.length,
              (index) => GestureDetector(
                onTap: () {
                  launchUrlString(
                    Config.sponsorsLinks[index],
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: SponsorsCard(
                  imageUrl: Config.sponsorsImages[index],
                  description: Config.sponsorsDescription[index],
                  descriptionColor: Config.sponsorsColors[index],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff3274ee),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  launchUrlString(
                    "https://drive.google.com/file/d/1RG_bs9SrR03GAiHa-qAgE5Va7CeiUHAf/view",
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Become a Sponsor".toUpperCase(),
                      style: const TextStyle(
                          fontFamily: "GoogleSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const IndicatorHeading(
              title: "Community Partners",
              indicatorColor: Colors.blue,
            ),
            const SlidingCardsView(),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
