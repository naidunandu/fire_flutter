import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes/route_names.dart';
import 'routes/route_methods.dart';

import 'firebase_options.dart';
import 'services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => FirebaseAuthService().init());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter App",
      theme: ThemeData(useMaterial3: false, primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      getPages: AppRouteMethods.pages,
      initialRoute: AppRouteNames.splash,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
