import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_q/model/userModel.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password,String role) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;

    if (user != null) {

      final doc = await _firestore
          .collection('users')
          .doc(role)
          .collection('accounts')
          .doc(user.uid)
          .get();

      if (!doc.exists) {

        await _auth.signOut();
        throw Exception('You are not registered as a ${role}. Please select the correct role.');
      }
    }

    return result.user;
  }

  Future<User?> register(
      String email,
      String password,
      String name,
      String role,
      ) async {

    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {

      final roleDocRef = _firestore.collection('users').doc(role);

      await roleDocRef.set({
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));


      await roleDocRef.collection('accounts').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  Future<void> updateProfile(UserModel user) async {
    if (user.role == null || user.role!.isEmpty) {
      throw Exception('Role is missing. Cannot update profile.');
    }

    await _firestore
        .collection('users')
        .doc(user.role)
        .collection('accounts')
        .doc(user.uid)
        .set({
      'name': user.name,
      'phone': user.phone,
      'age': user.age,
      'bloodGroup': user.bloodGroup,
    }, SetOptions(merge: true));
  }

  Future<UserModel?> fetchUserProfile(String uid, String role) async {
    final doc = await _firestore
        .collection('users')
        .doc(role)
        .collection('accounts')
        .doc(uid)
        .get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> saveProfileDetails({
    required String uid,
    required String role,
    required String phone,
    required String age,
    required String bloodGroup,
  }) async {
    await _firestore
        .collection('users')
        .doc(role)
        .collection('accounts')
        .doc(uid)
        .set({
      'phone': phone,
      'age': age,
      'bloodGroup': bloodGroup,
    }, SetOptions(merge: true));
  }

  Future<void> logout() async {
    await _auth.signOut();

  }
}