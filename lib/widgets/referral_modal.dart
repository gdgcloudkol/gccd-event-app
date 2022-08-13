import 'package:ccd2022app/blocs/referral_bloc.dart';
import 'package:flutter/material.dart';

class ReferralModal extends StatelessWidget {
  const ReferralModal({Key? key, required this.rb}) : super(key: key);

  final ReferralBloc rb;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 7,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Referral Stats",
          style: TextStyle(
            fontFamily: 'GoogleSans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: Colors.black54,
          thickness: 0.8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Ongoing",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 6,
                  child: CircleAvatar(
                    radius: 50,
                    // backgroundColor: const Color(0xfff4f7fe),
                    backgroundImage: const AssetImage(
                      "assets/images/ccd_background.png",
                    ),
                    child: Text(
                      rb.ongoingReferrals.toString(),
                      style: const TextStyle(
                        color: Color(0xff93b5f1),
                        fontSize: 35,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 6,
                  child: CircleAvatar(
                    radius: 50,
                    // backgroundColor: const Color(0xfff4f7fe),
                    backgroundImage: const AssetImage(
                      "assets/images/ccd_background.png",
                    ),
                    child: Text(
                      rb.completeReferrals.toString(),
                      style: const TextStyle(
                        color: Color(0xff93b5f1),
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const Divider(
          color: Colors.black54,
          thickness: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            getReferralGoalText(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 90,
        )
      ],
    );
  }

  getReferralGoalText() {
    int completedReferrals = rb.completeReferrals;
    if (completedReferrals < 25) {
      return "${25 - completedReferrals} more referrals to go to unlock the mystery box. Keep hustling 🏃‍♂️";
    } else if (completedReferrals < 50) {
      return "Congratulations on winning the mystery box. ${50 - completedReferrals} more referrals to go to unlock conference pass. Keep hustling 🏃‍♂️";
    } else {
      return "Congratulations you have unlocked all rewards. Thanks for making Cloud Community Days 2022 better.";
    }
  }
}
