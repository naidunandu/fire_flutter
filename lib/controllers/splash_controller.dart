import 'package:fire_flutter/controllers/connectivity_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Get.put(ConnectivityController());
    super.onInit();
  }

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Employee Records, Let’s shop!",
      "image": "https://i.postimg.cc/wRtVxqR2/splash-3.png",
    }
  ];
}
