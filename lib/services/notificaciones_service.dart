import 'package:flutter/material.dart';

//
class NotificacionesService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSanckbar(String message, {required MaterialColor backgroundColor, required Duration duration}) {
    final snackbar = new SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.white24, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    backgroundColor: backgroundColor,
    duration: duration,
    
    );
    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
