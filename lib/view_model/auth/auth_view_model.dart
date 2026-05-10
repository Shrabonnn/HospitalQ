import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String?> login(String email, String password,String role) async {
    try {
      setLoading(true);

      await _repo.login(email, password,role);

      setLoading(false);
      return null;
    }on FirebaseAuthException catch (e) {
      setLoading(false);
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password.';
        default:
          return 'Login failed: ${e.message}';
      }
    } catch (e) {
      setLoading(false);
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  Future<String?> register(String email, String password, String name, String role,) async {
    try {
      setLoading(true);

      await _repo.register(email, password, name, role);

      setLoading(false);
      return null;
    }on FirebaseAuthException catch (e) {
      setLoading(false);
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email is already registered. Please sign in.';
        case 'weak-password':
          return 'Password must be at least 6 characters.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        default:
          return 'Registration failed: ${e.message}';
      }
    } catch (e) {
      setLoading(false);
      debugPrint('Firestore save failed: $e');
      return e.toString();
    }
  }
}