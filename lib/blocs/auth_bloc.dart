import 'package:ccd2022app/blocs/nav_bloc.dart';
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

  bool _eligibleForReferral = false;

  bool get eligibleForReferral => _eligibleForReferral;

  ///Fetches session data when app opens
  AuthBloc() {
    loadUserDataFromSp();
  }

  loginWithGoogle(
      BuildContext context, TicketStatusBloc tsb, NavigationBloc nb) async {
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
          if (nb.navigatorKey.currentState != null) {
            showSnackBar(
                nb.navigatorKey.currentState!.context, "Invalid Credential");
          }
        }

        setLoginProgress(false);
      } catch (e) {
        if (nb.navigatorKey.currentState != null) {
          showSnackBar(nb.navigatorKey.currentState!.context, e.toString());
        }
        setLoginProgress(false);
      }

      if (user != null) {
        _isLoggedIn = true;
        _email = user.email ?? "";
        _name = user.displayName ?? "";
        _uid = user.uid;
        _profilePicUrl = user.photoURL ?? "";

        List checkResult = await checkIfUserExists(_uid);
        bool userExists = checkResult[1];

        if (!userExists) {
          await saveDataToFirestore();
        } else {
          _eligibleForReferral = (checkResult[0][Config.fsfEligibleForReferral] ?? false);
        }

        if (nb.navigatorKey.currentState != null) {
          showSnackBar(
              nb.navigatorKey.currentState!.context, "Logged In Successfully");
        }
        await saveUserDataToSp();
        tsb.checkTicketStatus();
      } else {
        if (nb.navigatorKey.currentState != null) {
          showSnackBar(nb.navigatorKey.currentState!.context,
              "Error logging you in. Try Again");
        }
      }

      setLoginProgress(false);
    } else {
      if (nb.navigatorKey.currentState != null) {
        showSnackBar(
            nb.navigatorKey.currentState!.context, "Login cancelled by user");
      }
      setLoginProgress(false);
    }
  }

  ///Update _loginInProgress state variable
  void setLoginProgress(bool value) {
    _loginInProgress = value;
    notifyListeners();
  }

  ///Saves user data to session
  Future saveUserDataToSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Config.prefEmail, email);
    sp.setString(Config.prefName, name);
    sp.setString(Config.prefUID, uid);
    sp.setString(Config.prefProfilePicUrl, profilePicUrl);
    sp.setBool(Config.prefLoggedIn, isLoggedIn);
    sp.setBool(Config.prefEligibleForReferral, eligibleForReferral);
  }

  ///Loads user data from Session
  Future loadUserDataFromSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _isLoggedIn = sp.getBool(Config.prefLoggedIn) ?? false;
    if (isLoggedIn) {
      _email = sp.getString(Config.prefEmail) ?? "";
      _name = sp.getString(Config.prefName) ?? "";
      _uid = sp.getString(Config.prefUID) ?? "";
      _eligibleForReferral =
          sp.getBool(Config.prefEligibleForReferral) ?? false;
      _profilePicUrl = sp.getString(Config.prefProfilePicUrl) ?? "";
    }
    notifyListeners();
  }

  ///Checks if user exists and returns boolean status accordingly
  Future checkIfUserExists(String uid) async {
    bool userExists = true;
    Map<String, dynamic> data = {};

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
        } else {
          data = value.docs[0].data();
        }
      },
    );
    return [data, userExists];
  }

  void signOut(
    BuildContext context,
    TicketStatusBloc tsb,
    NavigationBloc nb,
  ) async {
    ///Step 0 : Clear Session
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();

    ///Step 2 : Clear variables used in UI
    _isLoggedIn = false;
    _name = "";
    _profilePicUrl = "";
    _uid = "";
    _email = "";
    tsb.clearFields();

    ///Step 3 : Logout from auth providers
    await _googleSignIn.signOut();
    _firebaseAuth.signOut();

    ///Step 4 : Notify user

    if (nb.navigatorKey.currentState != null) {
      showSnackBar(
          nb.navigatorKey.currentState!.context, "Signed Out successfully");
      if (nb.navIndex == 7) {
        nb.changeNavIndex(0);
      }
    }
    notifyListeners();
  }

  ///To be called if user doesn't exist in firestore
  Future saveDataToFirestore() async {
    await FirebaseFirestore.instance.collection(Config.fscUsers).doc(uid).set({
      Config.fsfUid: uid,
      Config.fsfName: name,
      Config.fsfEmail: email,
      Config.fsfLoginProvider: "Google",
      Config.fsfEligibleForReferral: true,
    });
    _eligibleForReferral = true;
  }
}
