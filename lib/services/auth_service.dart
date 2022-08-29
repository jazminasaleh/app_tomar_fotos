import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  //Token de acceso a la api de firbase
  final String _firbaseToken = 'AIzaSyDUtCpRkkBkWKCa36kZf6jqeXCTn5kB3HM';
  //grabar token en el secure storage
  final storage = new FlutterSecureStorage();
//Crerar un nuevo usuario
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firbaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeResp['idToken']);
      //return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken' : true
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firbaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      //return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  //borrrar el storage
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToke() async{
    return await storage.read(key: 'token') ?? '';
  }
}
