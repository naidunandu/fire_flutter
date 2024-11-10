class Employee {
  final String id;
  final String name;
  final String position;

  Employee({required this.id, required this.name, required this.position});

  // Convert from Firestore to Employee object
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      position: map['position'],
    );
  }

  // Convert to Map to store in SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
    };
  }
}
