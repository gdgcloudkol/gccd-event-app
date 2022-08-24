import 'dart:convert';

import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@category Blocs}
class TicketStatusBloc extends ChangeNotifier {
  final _storage = FirebaseStorage.instance;

  bool _hasApplied = false;
  bool _ticketGranted = false;

  bool get hasApplied => _hasApplied;

  bool get ticketGranted => _ticketGranted;

  ///Conference Ticket image url
  String _confTicketImageUrl = "";

  String get confTicketImageUrl => _confTicketImageUrl;

  ///Ticket image url
  String _workshopTicketImageUrl = "";

  String get workshopTicketImageUrl => _workshopTicketImageUrl;

  bool _loading = true;

  bool get loading => _loading;

  bool _rejected = false;

  bool get rejected => _rejected;

  dynamic _applicantData;

  dynamic get applicantData => _applicantData;

  ///Call to checkTicketStatus() from constructor to fetch data on first app load
  TicketStatusBloc() {
    checkTicketStatus().then((value) => loadDataFromPrefs());
  }

  ///clearFields() to be used on logout to reset ticket status
  void clearFields() {
    _hasApplied = false;
    _ticketGranted = false;
    _confTicketImageUrl = "";
    _workshopTicketImageUrl = "";
    _loading = false;
    _applicantData = null;
    notifyListeners();
  }

  ///Function to fetch ticket status from Firestore (From Shared Preferences occasionally)
  ///Fetches ticket url for applicants who got their ticket applications approved
  Future checkTicketStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    ///Check if logged in, else no need to check for ticket application
    if (sp.getBool(Config.prefLoggedIn) ?? false) {
      ///Step 0///
      ///Checking session cache if ticket is already present
      ///If yes no need to go to firestore

      if (sp.getBool(Config.prefHasTicket) ?? false) {
        _hasApplied = true;
        _ticketGranted = true;
        _confTicketImageUrl =
            sp.getString(Config.prefConferenceTicketImageUrl) ?? "";
        _workshopTicketImageUrl =
            sp.getString(Config.prefWorkshopTicketImageUrl) ?? "";
        _loading = false;
        notifyListeners();

        ///Returning only if both tickets are present
        if (_confTicketImageUrl.isNotEmpty &&
            _workshopTicketImageUrl.isNotEmpty) {
          return;
        }
      } else if (sp.getBool(Config.prefTicketRejected) ?? false) {
        _hasApplied = true;
        _ticketGranted = false;
        _rejected = true;
        _loading = false;
        notifyListeners();
        return;
      }

      ///End of Step 0///
      _loading = true;
      notifyListeners();

      ///Step 1///
      ///Checking if application exists and whether it was rejected
      ///If yes, go to Step 2
      DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection(Config.fscTicketFormRegistrations)
          .doc(sp.getString(Config.prefUID))
          .get();

      if (snap.exists) {
        sp.setString(Config.prefProfile, json.encode(snap.data()));
        _hasApplied = true;
      } else {
        _hasApplied = false;
      }

      ///End of Step 1///

      ///Step 2///
      ///Checking if ticket exists
      ///If yes fetch ticket url from Firebase Storage and
      ///cache in shared preferences so that
      ///we don't make redundant api calls from next time
      if (_hasApplied) {
        ///Checking if ticket was rejected
        if (snap.data() != null &&
            (snap.data() ?? {}).containsKey(Config.fsfRejected)) {
          _ticketGranted = false;
          _rejected = true;
          sp.setBool(Config.prefTicketRejected, true);
        }
      }

      ///End of Step 1///

      ///Step 2///
      ///Checking if ticket exists
      ///If yes fetch ticket url from Firebase Storage and
      ///cache in shared preferences so that
      ///we don't make redundant api calls from next time
      if (_hasApplied && !_rejected) {
        ///Checking if ticket was granted

        String uid = sp.getString(Config.prefUID) ?? "";
        DocumentSnapshot<Map<String, dynamic>> snapTicket =
            await FirebaseFirestore.instance
                .collection(Config.fscTickets)
                .doc(uid)
                .get();
        if (snapTicket.exists && snapTicket.data() != null) {
          _ticketGranted = true;
          ListResult result = await _storage.ref("$uid/").listAll();

          if (snapTicket.data()![Config.fsfConference] &&
              _confTicketImageUrl.isEmpty) {
            _confTicketImageUrl = await result.items[0].getDownloadURL();

            sp.setBool(Config.prefHasTicket, true);
            sp.setString(
              Config.prefConferenceTicketImageUrl,
              confTicketImageUrl,
            );

            _loading = false;
            notifyListeners();
          }

          if (snapTicket.data()![Config.fsfWorkshop] &&
              _workshopTicketImageUrl.isEmpty) {
            _workshopTicketImageUrl = await result.items[1].getDownloadURL();

            sp.setBool(Config.prefHasTicket, true);
            sp.setString(
              Config.prefWorkshopTicketImageUrl,
              workshopTicketImageUrl,
            );

            _loading = false;
            notifyListeners();
          }
        } else {
          _ticketGranted = false;
        }
      }

      ///End of Step 2///

    }

    _loading = false;
    notifyListeners();
  }

  void loadDataFromPrefs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!(sp.getBool(Config.prefLoggedIn) ?? false)) {
      return;
    }

    try {
      String? data = sp.getString(Config.prefProfile);

      if (data == null) {
        DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
            .instance
            .collection(Config.fscTicketFormRegistrations)
            .doc(sp.getString(Config.prefUID))
            .get();

        _applicantData = snap.data();
        sp.setString(Config.prefProfile, json.encode(snap.data()));
      } else {
        _applicantData = json.decode(data);
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }
}
