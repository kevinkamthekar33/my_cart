import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static final AuthHelper authHelper = AuthHelper._();

  Future<User?> loginWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'password is weak') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    if (credential != null) {
      return credential.user;
    } else {
      return null;
    }
  }

  Future<User?> signupWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
    if (credential != null) {
      return credential.user;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
