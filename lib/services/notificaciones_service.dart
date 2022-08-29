import 'package:flutter/material.dart';

class NotificacionesService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSanckbar(String message) {
    final snackbar = new SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ));
    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
