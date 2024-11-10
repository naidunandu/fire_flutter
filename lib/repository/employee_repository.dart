import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employees.dart';
import '../services/database_service.dart';

class EmployeeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Employee>> getEmployees() async* {
    List<Employee> cachedEmployees = await _dbHelper.getEmployees();
    if (cachedEmployees.isNotEmpty) yield cachedEmployees;
    await for (var snapshot in _firestore.collection('employees').snapshots()) {
      List<Employee> employees = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Employee(
          id: doc.id,
          name: data['name'],
          position: data['position'],
        );
      }).toList();
      yield employees;
      await _dbHelper.insertEmployees(employees);
    }
  }

  Future refreshEmployees() async {
    var snapshot = await _firestore.collection('employees').get();
    List<Employee> employees = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Employee(
        id: doc.id,
        name: data['name'],
        position: data['position'],
      );
    }).toList();
    await _dbHelper.insertEmployees(employees);
  }

  Future<void> addEmployee(String name, String position) async {
    await _firestore.collection('employees').add({
      'name': name,
      'position': position,
    });
  }
}
