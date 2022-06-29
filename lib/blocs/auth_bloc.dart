import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var errorMessage = '';
  UserCredential? _credential;

  loginWithGoogle() {
    ///TODO implementation
  }

  loginWithGithub() {
    ///TODO implementation
  }

  loginWithEmailPassword(String email, String password) async {
    try {
      _credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      errorMessage = '';
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  signUpWithEmailPassword(String email, String password) async {
    try {
      _credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      } else {
        errorMessage = e.code;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
