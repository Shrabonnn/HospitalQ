import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/department_model.dart';

class DepartmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DepartmentModel>> fetchDepartments() {

    return _firestore
        .collection('departments')
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {
        return DepartmentModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();

    });
  }
}