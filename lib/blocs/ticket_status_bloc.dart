import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketStatusBloc extends ChangeNotifier {
  final _storage = FirebaseStorage.instance;

  bool _hasApplied = false;
  bool _ticketGranted = false;

  bool get hasApplied => _hasApplied;

  bool get ticketGranted => _ticketGranted;

  String _confTicketImageUrl = "";

  String get confTicketImageUrl => _confTicketImageUrl;

  bool _loading = true;

  bool get loading => _loading;

  TicketStatusBloc() {
    checkTicketStatus();
  }

  void clearFields() {
    _hasApplied = false;
    _ticketGranted = false;
    notifyListeners();
  }

  Future checkTicketStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getBool(Config.prefLoggedIn) ?? false) {
      if (sp.getBool(Config.prefHasTicket) ?? false) {
        _hasApplied = true;
        _ticketGranted = true;
        _confTicketImageUrl =
            sp.getString(Config.prefConferenceTicketImageUrl) ?? "";
        _loading = false;
        notifyListeners();
        return;
      }

      _loading = true;
      notifyListeners();
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection(Config.fscTicketFormRegistrations)
          .doc(sp.getString(Config.prefUID))
          .get();

      if (snap.exists) {
        _hasApplied = true;
      } else {
        _hasApplied = false;
      }

      if (_hasApplied) {
        String uid = sp.getString(Config.prefUID) ?? "";
        DocumentSnapshot snapTicket = await FirebaseFirestore.instance
            .collection(Config.fscTickets)
            .doc(uid)
            .get();
        if (snapTicket.exists) {
          _ticketGranted = true;
          ListResult result = await _storage.ref("$uid/").listAll();

          _confTicketImageUrl = await result.items[0].getDownloadURL();

          sp.setBool(Config.prefHasTicket, true);
          sp.setString(Config.prefConferenceTicketImageUrl, confTicketImageUrl);
        } else {
          _ticketGranted = false;
        }
      }
    }
    _loading = false;
    notifyListeners();
  }
}
