import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn get googleSignIn => _googleSignIn;

  SharedPreferences? sp;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  String _email = "";

  String get email => _email;

  String _name = "";

  String get name => _name;

  String _uid = "";

  String get uid => _uid;

  String _profilePicUrl = "";

  String get profilePicUrl => _profilePicUrl;

  AuthBloc() {
    loadUserDataFromSp();
  }

  loginWithGoogle(BuildContext context, TicketStatusBloc tsb) async {
    setLoginProgress(true);

    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          showSnackBar(context, "Invalid Credential");
        }

        setLoginProgress(false);
      } catch (e) {
        showSnackBar(context, e.toString());
        setLoginProgress(false);
      }

      if (user != null) {
        _isLoggedIn = true;
        _email = user.email ?? "";
        _name = user.displayName ?? "";
        _uid = user.uid;
        _profilePicUrl = user.photoURL ?? "";
        bool userExists = await checkIfUserExists(_uid);
        if (!userExists) {
          await saveDataToFirestore(loginProvider: "google");
        }
        showSnackBar(context, "Logged In Successfully");
        await saveUserDataToSp();
        tsb.checkTicketStatus();
      } else {
        showSnackBar(context, "Error logging you in. Try Again");
      }

      setLoginProgress(false);
    } else {
      showSnackBar(context, "Login cancelled by user");
      setLoginProgress(false);
    }
  }

  void setLoginProgress(bool value) {
    _loginInProgress = value;
    notifyListeners();
  }

  Future saveUserDataToSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Config.prefEmail, email);
    sp.setString(Config.prefName, name);
    sp.setString(Config.prefUID, uid);
    sp.setString(Config.prefProfilePicUrl, _profilePicUrl);
    sp.setBool(Config.prefLoggedIn, isLoggedIn);
  }

  Future loadUserDataFromSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _isLoggedIn = sp.getBool(Config.prefLoggedIn) ?? false;
    if (isLoggedIn) {
      _email = sp.getString(Config.prefEmail) ?? "";
      _name = sp.getString(Config.prefName) ?? "";
      _uid = sp.getString(Config.prefUID) ?? "";
      _profilePicUrl = sp.getString(Config.prefProfilePicUrl) ?? "";
    }
    notifyListeners();
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

  void signOut(
    BuildContext context,
    TicketStatusBloc tsb,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    _isLoggedIn = false;
    _name = "";
    _profilePicUrl = "";
    _uid = "";
    _email = "";
    await _googleSignIn.signOut();
    _firebaseAuth.signOut();
    tsb.clearFields();
    showSnackBar(context, "Signed Out successfully");
    notifyListeners();
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
