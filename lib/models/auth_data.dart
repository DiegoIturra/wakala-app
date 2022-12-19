import 'dart:convert';

class AuthData{
  final int id;
  final String email;
  final String name;

  const AuthData({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['id'],
      name: json['nombre'],
      email: json['email'],
    );
  }
}