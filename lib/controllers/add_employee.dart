import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fire_flutter/helpers/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/employee_repository.dart';

class AddEmployeeController extends GetxController {
  final EmployeeRepository employeeRepository = EmployeeRepository();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPosition = TextEditingController();

  Future<void> addEmployee() async {
    final name = txtName.text.trim();
    final position = txtPosition.text.trim();

    if (name.isNotEmpty && position.isNotEmpty) {
      await employeeRepository.addEmployee(name, position);
      Get.back();
      showAlert("Success", "Employee Added!", ContentType.success);
    } else {
      showAlert("Warning", "Please enter both name and position", ContentType.warning);
    }
  }
}
