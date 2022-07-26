import 'package:ccd2022app/models/TicketFormModel.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketFormBloc extends ChangeNotifier {

  Future createNewRegistration(String uid, TicketFormModel model) async {
    await FirebaseFirestore.instance
        .collection(Config.fscTicketFormRegistrations)
        .doc(uid)
        .set(model.toMap());
  }

}
