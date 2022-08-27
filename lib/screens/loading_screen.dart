import 'package:flutter/material.dart';
//para que una pantalla tenga la bolita de craga
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text('Products'),
     ),
     body: Center(
      child: CircularProgressIndicator(
        color: Colors.indigo,
      ),
     ),
    );
  }
}