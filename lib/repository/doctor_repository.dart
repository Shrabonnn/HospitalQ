import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_q/model/doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DoctorModel>> fetchDoctorsByDepartment(String departmentId) {

    return _firestore
        .collection('doctors')
        .where('departmentId', isEqualTo: departmentId)
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {
        return DoctorModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();

    });
  }
}