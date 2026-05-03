import 'package:flutter/material.dart';

import '../../data/services/auth_repository.dart';


class AuthViewModel with ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  bool loading = false;

  bool get isLoading => loading;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      setLoading(true);

      await _repo.login(email, password);

      setLoading(false);
      return null;
    } catch (e) {
      setLoading(false);
      return e.toString();
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      setLoading(true);

      await _repo.register(email, password);

      setLoading(false);
      return null;
    } catch (e) {
      setLoading(false);
      return e.toString();
    }
  }
}