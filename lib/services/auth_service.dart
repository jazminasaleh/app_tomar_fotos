import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  //La base a la cual se le hara la peticion http
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  //Token de acceso a la api de firbase
  final String _firbaseToken = 'AIzaSyDUtCpRkkBkWKCa36kZf6jqeXCTn5kB3HM';
  //grabar token en el secure storage
  final storage = new FlutterSecureStorage();

//Crerar un nuevo usuario y se verifica que el correo no exista
  Future<String?> createUser(String email, String password) async {
    //Como es una peticion post debe ser map
    //Se cra la iofomracion del post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    //El segundo argumento es tomado de la segunda parte del enlace antes del key
    //Se crea el url que es el mismo que se tiene en postamn
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firbaseToken});
    //se dispara la peticion http
    final resp = await http.post(url, body: json.encode(authData));
    //y se decodifica la respuesta y ahi tendremos idToken o error
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
   //devuelve el idtoekn
    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      //error
      return decodeResp['error']['message'];
    }
  }

  //En el login se mira que el corrreo y la contraseña esten bien
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
    if (decodeResp.containsKey('idToken')) {
      //grabar la informacion
      await storage.write(key: 'token', value: decodeResp['idToken']);
      //return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  //borrrar del storage(almacenamineo local)
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToke() async{
    return await storage.read(key: 'token') ?? '';
  }
}
