import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ReferralBloc extends ChangeNotifier {
  Future createNewReferral(
    String uid,
    String referralCode,
    AuthBloc ab,
    NavigationBloc nb,
  ) async {
    ///Check if referral code is valid
    bool validReferralCode = (await ab.checkIfUserExists(referralCode))[1];

    if (!validReferralCode) {
      if (nb.navigatorKey.currentContext != null) {
        showSnackBar(
            nb.navigatorKey.currentContext!, "Invalid Referral Code ❌");
      }
      return;
    }

    ///Setting referrer's referral code in user's doc
    ///to track referral when form will be filled
    ///Also sets eligibility for referral to false as a
    ///user can't be referred twice
    await FirebaseFirestore.instance
        .collection(Config.fscUsers)
        .doc(uid)
        .update({
      Config.fsfReferredBy: referralCode,
      Config.fsfEligibleForReferral: false,
    });

    ///Updating frontend to remove referral enter space
    ab.setIneligibleForReferral();

    ///Adding uid to ongoing referrals of referrer
    await FirebaseFirestore.instance
        .collection(Config.fscUsers)
        .doc(referralCode)
        .update({
      Config.fsfOngoingReferrals: FieldValue.arrayUnion([uid]),
    });

    if (nb.navigatorKey.currentContext != null) {
      showSnackBar(nb.navigatorKey.currentContext!, "Referral code accepted ✅");
    }
  }

  ///Used when user submits form for application
  ///Updates ongoingReferral to completeReferral
  Future changeOngoingReferralToCompletedReferral(
      String uid, String referralCode) async {
    await FirebaseFirestore.instance
        .collection(Config.fscUsers)
        .doc(referralCode)
        .update({
      Config.fsfOngoingReferrals: FieldValue.arrayRemove([uid]),
      Config.fsfCompleteReferrals: FieldValue.arrayUnion([uid]),
    });
  }
}
