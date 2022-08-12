import 'package:ccd2022app/blocs/community_partners_bloc.dart';
import 'package:ccd2022app/models/community_partners_model.dart';
import 'package:ccd2022app/screens/sponsors/cards/sliding_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
      setState(() => pageOffset = (pageController?.page ?? 0));

      ///<-- add listener and set state
    });
  }

  @override
  void dispose() {
    pageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommunityPartnersBloc cpb = Provider.of<CommunityPartnersBloc>(context);

    return SizedBox(
      height: 400,
      child: FutureBuilder<List<CommunityPartners>?>(
        future: cpb.fetchCommunityPartners(http.Client(), context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
                height: 100,
                child: Center(
                  child: Text("Error Fetching Community Partners"),
                ));
          } else if (snapshot.hasData) {
            if ((snapshot.data ?? []).isEmpty) {
              return const SizedBox(
                height: 100,
                child: Center(
                  child: Text("No Community Partners Found"),
                ),
              );
            } else {
              return snapshot.hasData
                  ? PageView(
                      controller: pageController,
                      children:
                          List.generate((snapshot.data ?? []).length, (index) {
                        CommunityPartners partner = snapshot.data![index];
                        return SlidingCard(
                          name: partner.communityName,
                          chapter: partner.chapter,
                          url: partner.url,
                          offset: pageOffset - index,
                          logo: partner.logo,
                        );
                      }),
                    )
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }
          }
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
