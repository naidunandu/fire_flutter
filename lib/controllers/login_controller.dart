import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fire_flutter/helpers/alerts.dart';
import 'package:fire_flutter/routes/route_names.dart';
import 'package:fire_flutter/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class LoginController extends GetxController {
  FirebaseAuthService authService = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool isLoading = false;
  onSubmit() async {
    bool hasInternetAccess = await InternetConnection().hasInternetAccess;
    if (hasInternetAccess) {
      if (formKey.currentState!.validate()) {
        try {
          isLoading = true;
          update();
          String email = txtEmailAddress.text;
          String password = txtPassword.text;
          User? user = await authService.signInWithEmailAndPassword(email, password);
          user ??= await authService.registerWithEmailAndPassword(email, password);
          isLoading = false;
          update();
          if (user != null) {
            Get.toNamed(AppRouteNames.home);
          }
        } catch (err) {
          if (kDebugMode) {
            print("onCatch");
            print(err.toString());
            isLoading = false;
            update();
          }
        }
      }
    } else {
      showAlert("Warning", "Not Internet Access", ContentType.warning);
    }
  }
}
