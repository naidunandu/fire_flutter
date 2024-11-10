import 'package:fire_flutter/services/firebase_auth_service.dart';
import 'package:get/get.dart';

import '../repository/employee_repository.dart';

class HomeController extends GetxController {
  final EmployeeRepository employeeRepository = EmployeeRepository();

  onRefreshIndicator() async {
    await employeeRepository.refreshEmployees();
  }

  onLogout() async {
    FirebaseAuthService firebaseAuthService = Get.find();
    await firebaseAuthService.signOut();
    Get.back();
  }
}
