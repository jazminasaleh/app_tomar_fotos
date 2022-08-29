import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  //Token de acceso a la api de firbase
  final String _firbaseToken = 'AIzaSyDUtCpRkkBkWKCa36kZf6jqeXCTn5kB3HM';

//Crerar un nuevo usuario
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firbaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firbaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }
}
