import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String? name;
  final String? email;
  final String? role;
  final String? phoneNumber;
  final Timestamp? createdAt;

  Profile({
    this.name,
    this.email,
    this.role,
    this.phoneNumber,
    this.createdAt,
  });

  factory Profile.fromMap(Map<String, dynamic> data) {
    return Profile(
      name: data['name'],
      email: data['email'],
      role: data['role'],
      phoneNumber: data['phoneNumber'],
      createdAt: data['createdAt'],
    );
  }
}
