// lib/view_models/home_view_model.dart

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hospital_q/model/department_model.dart';
import 'package:hospital_q/repository/department_repository.dart';
import '../model/hospital_model.dart';

class HomeViewModel extends ChangeNotifier {

  final DepartmentRepository _repository = DepartmentRepository();


  List<DepartmentModel> _departments = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription<List<DepartmentModel>>? _departmentSubscription; // 👈 hold the sub


  List<DepartmentModel> get departments => _departments;
  bool get isLoading => _isLoading;

  HomeViewModel() {
    fetchDepartments();
    _initGreeting();
  }

  void fetchDepartments() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _departmentSubscription = _repository.fetchDepartments().listen((data) {
        _departments = data;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }



  // ── Private State ──────────────────────────────────
  String _userName = 'Rahim Uddin';
  String _greeting = '';
  bool _hasNotification = true;

  final int _activeToken = 47;
  final int _servingNow = 38;
  final int _waitMinutes = 45;
  final String _activeDepartment = 'Medicine';
  final String _activeHospitalShort = 'DMCH';





  // ── Public Getters ────────
  String get userName => _userName;
  String get greeting => _greeting;
  bool get hasNotification => _hasNotification;
  int get activeToken => _activeToken;
  int get servingNow => _servingNow;
  int get waitMinutes => _waitMinutes;
  String get activeDepartment => _activeDepartment;
  String get activeHospitalShort => _activeHospitalShort;

  // ── Business Logic ─────────────────────────────────
  void _initGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      _greeting = 'Good morning,';
    } else if (hour < 17) {
      _greeting = 'Good afternoon,';
    } else {
      _greeting = 'Good evening,';
    }
    // no notifyListeners() needed — called in constructor before UI builds
  }

  void clearNotification() {
    if (_hasNotification) {
      _hasNotification = false;
      notifyListeners();    // UI re-renders the red dot away
    }
  }
}