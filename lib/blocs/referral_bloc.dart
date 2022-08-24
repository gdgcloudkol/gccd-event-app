import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/nav_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@category Blocs}
class ReferralBloc extends ChangeNotifier {
  int _ongoingReferrals = 0;

  int _completeReferrals = 0;

  int get ongoingReferrals => _ongoingReferrals;

  int get completeReferrals => _completeReferrals;

  bool _isCountersLoading = true;

  bool get isCountersLoading => _isCountersLoading;

  ReferralBloc() {
    getReferralCounters();
  }

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
    ab.setIneligibleForReferral(referralCode);

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

  ///Fetches the number of ongoing and complete referrals
  Future getReferralCounters() async {
    try {
      _isCountersLoading = true;
      notifyListeners();
      SharedPreferences sp = await SharedPreferences.getInstance();
      String uid = sp.getString(Config.prefUID) ?? "";
      if (uid == "") {
        _isCountersLoading = false;
        notifyListeners();
        return;
      }
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(Config.fscUsers)
          .doc(uid)
          .get();

      Map<String, dynamic> data = snapshot.data() ?? {};

      if (data.containsKey(Config.fsfOngoingReferrals)) {
        if (data[Config.fsfOngoingReferrals] == null) {
          _ongoingReferrals = 0;
        } else {
          _ongoingReferrals = data[Config.fsfOngoingReferrals].length;
        }
      } else {
        _ongoingReferrals = 0;
      }

      if (data.containsKey(Config.fsfCompleteReferrals)) {
        if (data[Config.fsfCompleteReferrals] == null) {
          _completeReferrals = 0;
        } else {
          _completeReferrals = data[Config.fsfCompleteReferrals].length;
        }
      } else {
        _completeReferrals = 0;
      }

      _isCountersLoading = false;
      notifyListeners();
    } catch (e) {
      _isCountersLoading = false;
      _completeReferrals = 0;
      _ongoingReferrals = 0;
    }
  }
}
