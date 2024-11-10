import 'package:fire_flutter/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/employees.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            automaticallyImplyLeading: false,
            title: const Text("Employees"),
            actions: [
              IconButton(
                onPressed: () => ctrl.onLogout(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: StreamBuilder<List<Employee>>(
            stream: ctrl.employeeRepository.getEmployees(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading employees"),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No employees found"),
                );
              }

              final employees = snapshot.data!;
              return RefreshIndicator(
                onRefresh: () => ctrl.onRefreshIndicator(),
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(employees[index].name),
                      subtitle: Text(employees[index].position),
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Get.toNamed(AppRouteNames.addEmployee),
            icon: const Icon(Icons.add),
            label: const Text("Add Employee"),
          ),
        );
      },
    );
  }
}
