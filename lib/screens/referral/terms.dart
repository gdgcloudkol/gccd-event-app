import 'package:flutter/material.dart';

class ReferralTerms extends StatelessWidget {
  const ReferralTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          buildSingleTerm(
            "1.",
            "Existing users will be eligible to share their referral code"
                " but users must signup using versions 0.0.6 or above to be able to apply referral code.",
          ),
          const SizedBox(
            height: 10,
          ),
          buildSingleTerm(
            "2.",
            "Signups using websites won't count towards a user referral.",
          ),
          const SizedBox(
            height: 10,
          ),
          buildSingleTerm(
            "3.",
            "Only complete referrals count as eligible for prizes. Complete referrals "
                "are those users who completed filling up their ticket application form. "
                "All other users who just signup and enter a referral code are ongoing referral."
                " They will be considered ineligible once the contest ends.",
          ),
          const SizedBox(
            height: 10,
          ),
          buildSingleTerm(
            "4.",
            "Referring 25 users will grant you a mystery box. Referring 50 users will grant you a conference ticket",
          ),
          const SizedBox(
            height: 10,
          ),
          buildSingleTerm(
            "5.",
            "Offer valid till 25th August",
          ),
        ],
      ),
    );
  }

  Widget buildSingleTerm(
    String serial,
    String term,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          serial,
          style: const TextStyle(
            fontFamily: "GoogleSans",
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Flexible(
          child: Text(
            term,
            style: const TextStyle(
              fontFamily: "GoogleSans",
            ),
          ),
        ),
      ],
    );
  }
}
