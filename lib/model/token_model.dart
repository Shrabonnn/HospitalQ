// lib/model/token_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class TokenModel {
  final String id;
  final String hospitalId;
  final String departmentId;
  final int tokenNumber;
  final String status; // 'waiting' | 'called' | 'completed' | 'cancelled'
  final String userId;
  final Timestamp createdAt;
  final Timestamp? calledAt;
  final Timestamp? completedAt;

  const TokenModel({
    required this.id,
    required this.hospitalId,
    required this.departmentId,
    required this.tokenNumber,
    required this.status,
    required this.userId,
    required this.createdAt,
    this.calledAt,
    this.completedAt,
  });

  factory TokenModel.fromFirestore(
      DocumentSnapshot doc, {
        required String hospitalId,
        required String departmentId,
      }) {
    final data = doc.data() as Map<String, dynamic>;
    return TokenModel(
      id: doc.id,
      hospitalId: hospitalId,
      departmentId: departmentId,
      tokenNumber: (data['tokenNumber'] ?? 0) as int,
      status: data['status'] ?? 'waiting',
      userId: data['userID'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      calledAt: data['calledAt'] as Timestamp?,
      completedAt: data['completedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'tokenNumber': tokenNumber,
    'status': status,
    'userID': userId,
    'createdAt': createdAt,
    'calledAt': calledAt,
    'completedAt': completedAt,
  };
}