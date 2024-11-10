import 'package:fire_flutter/controllers/add_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddEmployeeController(),
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(title: const Text("Add Employee")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: ctrl.txtName,
                  readOnly: ctrl.isLoading,
                  decoration: InputDecoration(
                    hintText: "Name",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6), // Border radius of 6 pixels
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color when focused
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white, // Background color of the text box
                  ),
                ).marginOnly(bottom: 15),
                TextField(
                  controller: ctrl.txtPosition,
                  readOnly: ctrl.isLoading,
                  decoration: InputDecoration(
                    hintText: "Position",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6), // Border radius of 6 pixels
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color when focused
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white, // Background color of the text box
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  color: Colors.green,
                  onPressed: () => ctrl.addEmployee(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (ctrl.isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        ).marginOnly(right: 10),
                      const Text("Save"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
