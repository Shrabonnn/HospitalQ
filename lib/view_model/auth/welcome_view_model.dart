import 'package:flutter/widgets.dart';

class WelcomeViewModel with ChangeNotifier{
  String _selectedRole  = "Patinet";
  String get selectedRole => _selectedRole;

  bool get isPatient => _selectedRole == "Patient";

  bool get isStaff => _selectedRole == "Hospital Staff";

  void selectRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

}