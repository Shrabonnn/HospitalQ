// lib/view_models/home_view_model.dart

import 'package:flutter/foundation.dart';
import '../model/hospital_model.dart';

class HomeViewModel extends ChangeNotifier {

  // ── Private State ──────────────────────────────────
  String _userName = 'Rahim Uddin';
  String _greeting = '';
  bool _hasNotification = true;

  final int _activeToken = 47;
  final int _servingNow = 38;
  final int _waitMinutes = 45;
  final String _activeDepartment = 'Medicine';
  final String _activeHospitalShort = 'DMCH';

  final List<HospitalModel> _hospitals = const [
    HospitalModel(
      name: 'Dhaka Medical College',
      address: 'Bakshibazar, Dhaka',
      distance: '1.2 km',
      isOpen: true,
      departments: 6,
    ),
    HospitalModel(
      name: 'Sir Salimullah Medical',
      address: 'Mitford, Dhaka',
      distance: '2.4 km',
      isOpen: true,
      departments: 4,
    ),
    HospitalModel(
      name: 'Shaheed Suhrawardy',
      address: 'Sher-e-Bangla Nagar',
      distance: '4.1 km',
      isOpen: false,
      departments: 5,
    ),
    HospitalModel(
      name: 'National Heart Foundation',
      address: 'Mirpur, Dhaka',
      distance: '5.3 km',
      isOpen: false,
      departments: 3,
    ),
    HospitalModel(
      name: 'BSMMU Hospital',
      address: 'Shahbag, Dhaka',
      distance: '3.8 km',
      isOpen: true,
      departments: 8,
    ),
  ];

  // ── Constructor ────────────────────────────────────
  HomeViewModel() {
    _initGreeting();
  }

  // ── Public Getters ────────
  String get userName => _userName;
  String get greeting => _greeting;
  bool get hasNotification => _hasNotification;
  int get activeToken => _activeToken;
  int get servingNow => _servingNow;
  int get waitMinutes => _waitMinutes;
  String get activeDepartment => _activeDepartment;
  String get activeHospitalShort => _activeHospitalShort;
  List<HospitalModel> get hospitals => List.unmodifiable(_hospitals);

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