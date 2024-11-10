import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fire_flutter/helpers/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthService extends GetxService {
  Future<FirebaseAuthService> init() async => this;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Register a new user
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (err) {
      String error = err.toString();
      if (error.contains("[firebase_auth/weak-password]")) {
        error = error.split("[firebase_auth/weak-password]").last;
      }
      showAlert("Error", error, ContentType.failure);
      return null;
    }
  }

  // Sign in user
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (err) {
      String error = err.toString();
      if (error.contains("[firebase_auth/weak-password]")) {
        error = error.split("[firebase_auth/weak-password]").last;
      }
      showAlert("Error", error, ContentType.failure);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
