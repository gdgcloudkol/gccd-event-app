import 'package:ccd2022app/models/community_partners_model.dart';
import 'package:ccd2022app/screens/sponsors/cards/sliding_card_view_state.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:flutter/material.dart';

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
          children: const [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Community Partners",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SlidingCardsView(),
          ],
        ),
      ),
    );
  }
}
