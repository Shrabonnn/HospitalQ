import 'dart:async';

import 'package:flutter/material.dart';

import '../model/doctor_model.dart';
import '../repository/doctor_repository.dart';

class DoctorViewModel with ChangeNotifier {
  final DoctorRepository _repository = DoctorRepository();

  List<DoctorModel> _doctors = [];
  bool _isLoading = false;
  String? _error;

  StreamSubscription<List<DoctorModel>>? _doctorSubscription;

  List<DoctorModel> get doctors => _doctors;
  bool get isLoading => _isLoading;

  void fetchDoctorsByDepartment(String departmentId) {

    _isLoading = true;
    _error = null;
    notifyListeners();

    _doctorSubscription?.cancel();

    _doctorSubscription = _repository
        .fetchDoctorsByDepartment(departmentId)
        .listen(
          (data) {
        _doctors = data;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _doctorSubscription?.cancel();
    super.dispose();
  }
}