class UserModel {
  final String uid;
  final String name;
  final String email;
  String? role;
  final String phone;    // ← add
  final String age;
  final String bloodGroup;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.role,
    required this.phone,   // ← add
    required this.age,
    required this.bloodGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,      // ← add
      'age': age,
      'bloodGroup': bloodGroup,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      phone: map['phone'] ?? '',   // ← add
      age: map['age'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
    );
  }
}