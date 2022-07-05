import 'package:ccd2022app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends ChangeNotifier{

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

  loginWithGoogle(){
    ///TODO implementation
  }

  loginWithEmailPassword(){
    ///TODO implementation
  }

  signUpWithEmailPassword(){
    ///TODO implementation
  }

  void loginWithGitHub(BuildContext context) async {
    /// Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: dotenv.env["GITHUB_CLIENT_ID"] ?? "",
        clientSecret: dotenv.env["GITHUB_CLIENT_SECRET"] ?? "",
        redirectUrl: 'https://ccd2022-baae4.firebaseapp.com/__/auth/handler');

    /// Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    if (result.token != null) {
      /// Create a credential from the access token
      final githubAuthCredential =
      GithubAuthProvider.credential(result.token ?? "");

      /// Once signed in, capture the UserCredential
      UserCredential cred = await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);

      if (cred.user != null) {
        _name = cred.user?.displayName ?? "";
        _email = cred.user?.email ?? "";
        _uid = cred.user?.uid ?? "";
        _isLoggedIn = true;

        if (!(await checkIfUserExists(cred.user?.uid ?? ""))) {
          await saveDataToFirestore(loginProvider: "Github");
        }
        saveUserDataToSp();
      }
    }
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

  Future saveDataToFirestore(
      {String loginProvider = "Email"}) async {
    await FirebaseFirestore.instance.collection(Config.fscUsers).doc(uid).set({
      Config.fsfUid: uid,
      Config.fsfName: name,
      Config.fsfEmail: email,
      Config.fsfLoginProvider: loginProvider,
    });
  }

}