import 'package:flutter/widgets.dart';

class WelcomeViewModel with ChangeNotifier{
  String? _selectedRole ;
  String? get selectedRole => _selectedRole;

  bool get isPatient => _selectedRole == "Patient";

  bool get isStaff => _selectedRole == "Hospital Staff";
  bool get hasSelectedRole => _selectedRole != null;

  void selectRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

}