import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: (json["id"] as int?) ?? 0,
        username: (json["fullName"] as String?) ?? '',
        email: (json["email"] as String?) ?? '',
        role: (json["role"] as String?) ?? 'user',
      );
    } catch (e) {
      // Log do erro e dados problemáticos
      debugPrint('Error parsing User: $e');
      debugPrint('Problematic JSON: $json');

      return User(id: 0, username: '', email: '', role: 'user');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "role": role,
      };
}
