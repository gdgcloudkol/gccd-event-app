import 'package:ccd2022app/models/community_partners_model.dart';
import 'package:ccd2022app/screens/sponsors/cards/sliding_card_view_state.dart';
import 'package:ccd2022app/utils/config.dart';
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
            ...getHeading(Colors.green, "Sponsors"),
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
            ...getHeading(Colors.blue, "Community Partners"),
            const SlidingCardsView(),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getHeading(
    Color indicatorColor,
    String heading,
  ) {
    return [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: indicatorColor,
              ),
              width: 10,
              height: 70,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(
              heading,
              style: const TextStyle(
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
