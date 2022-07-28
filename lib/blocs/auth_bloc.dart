import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences? sp;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String _email = "";

  String get email => _email;

  String _name = "";

  String get name => _name;

  String _uid = "";

  String get uid => _uid;

  loginWithGoogle() {
    _firebaseAuth
        .signInWithPopup(
      GoogleAuthProvider(),
    )
        .then((authResult) {
      _isLoggedIn = true;
      _email = authResult.user!.email.toString();
      _name = authResult.user!.displayName.toString();
      _uid = authResult.user!.uid.toString();
      checkIfUserExists(_uid).then((value) {
        if (!value) {
          saveDataToFirestore(loginProvider: "google");
        }
      });
      saveUserDataToSp();
      notifyListeners();
    });
  }

  Future saveUserDataToSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Config.prefEmail, email);
    sp.setString(Config.prefName, name);
    sp.setString(Config.prefUID, uid);
    sp.setBool(Config.prefLoggedIn, isLoggedIn);
  }

  Future checkIfUserExists(String uid) async {
    bool userExists = true;
    await FirebaseFirestore.instance
        .collection(Config.fscUsers)
        .where(Config.fsfUid, isEqualTo: uid)
        .limit(1)
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty) {
          userExists = false;
        } else if (!value.docs[0].exists) {
          userExists = false;
        }
      },
    );
    return userExists;
  }

  void signOut() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    _firebaseAuth.signOut();
  }

  Future saveDataToFirestore({String loginProvider = "Email"}) async {
    await FirebaseFirestore.instance.collection(Config.fscUsers).doc(uid).set({
      Config.fsfUid: uid,
      Config.fsfName: name,
      Config.fsfEmail: email,
      Config.fsfLoginProvider: loginProvider,
    });
  }
}
