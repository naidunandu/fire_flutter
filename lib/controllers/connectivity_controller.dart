import 'package:fire_flutter/routes/route_names.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.isNotEmpty && result[0] == ConnectivityResult.none) {
      isConnected.value = false;
      Get.toNamed(AppRouteNames.noInternet);
    } else {
      if (!isConnected.value && Get.currentRoute == AppRouteNames.noInternet) {
        Get.back();
      }
      isConnected.value = true;
    }
  }
}
