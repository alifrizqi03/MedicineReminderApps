import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signwithGoogle() async {
    try {
      final googleuser = await _googleSignIn.signIn();
      if (googleuser == null) {
        return false;
      }
      final googleauth = await googleuser.authentication;
      final googlecredential = GoogleAuthProvider.credential(
          accessToken: googleauth.accessToken, idToken: googleauth.idToken);
      await _firebaseAuth.signInWithCredential(googlecredential);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "unknown error");
      return false;
    }
  }
}
