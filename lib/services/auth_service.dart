import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wakala_app/common/status.dart';
import 'package:wakala_app/models/auth_data.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAE1tYJodXyP06_C6eVbf6IiW4-9Vv3LJ8';
  final storage = FlutterSecureStorage();
  String mail = '';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Guaradar en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }


  Future<String?> login(String email, String password) async {
    final loginURL = 'https://d22292e4f79c.sa.ngrok.io/api/usuariosApi/GetUsuario?email=${email}&password=${password}';
    final loginResponse = await http.get(Uri.parse(loginURL));

    if(loginResponse.statusCode == 200){
      if(loginResponse.body.contains(email)){
        return status.LOGIN_SUCCESFUL.toString();
      }
      return status.LOGIN_ERROR.toString();
    }
    return status.LOGIN_ERROR.toString();
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return null;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
