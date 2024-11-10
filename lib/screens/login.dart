import 'package:fire_flutter/controllers/login_controller.dart';
import 'package:fire_flutter/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return GetBuilder(
              init: LoginController(),
              builder: (ctrl) {
                return Scaffold(
                  backgroundColor: Colors.grey.shade200,
                  body: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              SizedBox(height: constraints.maxHeight * 0.3),
                              Text(
                                "Sign In",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Let's start your session",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.02),
                              Form(
                                key: ctrl.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: ctrl.txtEmailAddress,
                                      decoration: const InputDecoration(
                                        hintText: 'Email Address',
                                        filled: true,
                                        fillColor: Color(0xFFF5FCF9),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                        if (!emailRegex.hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: ctrl.txtPassword,
                                        decoration: const InputDecoration(
                                          hintText: 'Password',
                                          filled: true,
                                          fillColor: Color(0xFFF5FCF9),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters long';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => ctrl.onSubmit(),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: const Color(0xFF00BF6D),
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(double.infinity, 48),
                                        shape: const StadiumBorder(),
                                      ),
                                      child: const Text("Sign in"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            // ignore: deprecated_member_use
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const HomeScreen(),
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
