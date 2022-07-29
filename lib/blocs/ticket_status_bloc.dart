import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketStatusBloc extends ChangeNotifier {
  bool _hasApplied = false;
  bool _ticketGranted = false;

  bool get hasApplied => _hasApplied;

  bool get ticketGranted => _ticketGranted;

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
        DocumentSnapshot snapTicket = await FirebaseFirestore.instance
            .collection(Config.fscTickets)
            .doc(sp.getString(Config.prefUID))
            .get();
        if (snapTicket.exists) {
          _ticketGranted = true;
          sp.setBool(Config.prefHasTicket, true);
        } else {
          _ticketGranted = false;
        }
      }
    }
    _loading = false;
    notifyListeners();
  }
}
