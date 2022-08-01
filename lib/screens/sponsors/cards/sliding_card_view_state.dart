import 'package:ccd2022app/models/community_partners_model.dart';
import 'package:ccd2022app/screens/sponsors/cards/sliding_card.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:flutter/material.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({Key? key}) : super(key: key);

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController? pageController;

  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController?.addListener(() {
      setState(() => pageOffset =
          (pageController?.page ?? 0)); //<-- add listener and set state
    });
  }

  @override
  void dispose() {
    pageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView(
        controller: pageController,
        children: List.generate(Config.communityPartners.length, (index) {
          CommunityPartnersModel model = Config.communityPartners[index];
          return SlidingCard(
            name: model.communityName,
            sub: model.subCommunityName,
            url: model.url,
            offset: pageOffset - index,
            logo: model.imagePath,
          );
        }),
      ),
    );
  }
}
