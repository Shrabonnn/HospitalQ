import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      // Step 2: Firestore এ check করো এই user টা selected role এ আছে কিনা
      final doc = await _firestore
          .collection('users')
          .doc(role) // "patient" or "staff"
          .collection('accounts')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        // Role match করেনি — logout করে error throw করো
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
      String role, // "patient" or "staff"
      ) async {
    // Step 1: Firebase Auth
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {
      // Step 2: parent document টা আগে create করো
      final roleDocRef = _firestore.collection('users').doc(role);

      await roleDocRef.set({
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // merge:true মানে আগে থাকলে overwrite হবে না

      // Step 3: এখন subcollection এ user save করো
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

  Future<void> logout() async {
    await _auth.signOut();
  }
}