import 'package:fire_flutter/routes/route_names.dart';
import 'package:fire_flutter/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuthService authService = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  onSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        String email = txtEmailAddress.text;
        String password = txtPassword.text;
        User? user = await authService.signInWithEmailAndPassword(email, password);
        user ??= await authService.registerWithEmailAndPassword(email, password);
        if (user != null) {
          Get.toNamed(AppRouteNames.home);
        }
      } catch (err) {
        if (kDebugMode) {
          print("onCatch");
          print(err.toString());
        }
      }
    }
  }
}
