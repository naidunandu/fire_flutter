import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fire_flutter/helpers/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../repository/employee_repository.dart';

class AddEmployeeController extends GetxController {
  final EmployeeRepository employeeRepository = EmployeeRepository();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPosition = TextEditingController();

  bool isLoading = false;
  Future<void> addEmployee() async {
    bool hasInternetAccess = await InternetConnection().hasInternetAccess;
    if (hasInternetAccess) {
      isLoading = true;
      update();
      final name = txtName.text.trim();
      final position = txtPosition.text.trim();

      try {
        if (name.isNotEmpty && position.isNotEmpty) {
          await employeeRepository.addEmployee(name, position);
          Get.back();
          showAlert("Success", "Employee Added!", ContentType.success);
        } else {
          showAlert("Warning", "Please enter both name and position", ContentType.warning);
        }
      } catch (err) {
        showAlert("Error", err.toString(), ContentType.failure);
      } finally {
        isLoading = false;
        update();
      }
    } else {
      showAlert("Warning", "Not Internet Access", ContentType.warning);
    }
  }
}
