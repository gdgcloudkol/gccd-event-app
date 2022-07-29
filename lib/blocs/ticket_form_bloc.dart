import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/entrypoint/navigation_screen.dart';
import 'package:ccd2022app/models/TicketFormModel.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketFormBloc extends ChangeNotifier {
  bool _entryCreationInProgress = false;

  bool get entryCreationInProgress => _entryCreationInProgress;

  Future createNewRegistration(
    String uid,
    TicketFormModel model,
    TicketStatusBloc tsb,
    BuildContext context,
  ) async {
    _entryCreationInProgress = true;
    notifyListeners();

    await FirebaseFirestore.instance
        .collection(Config.fscTicketFormRegistrations)
        .doc(uid)
        .set(model.toMap());

    _entryCreationInProgress = false;
    goToNavigationScreen(context);
    notifyListeners();
    tsb.checkTicketStatus();
  }

  void goToNavigationScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const NavigationScreen();
      }),
    );
  }
}
