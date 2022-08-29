import 'package:flutter/material.dart';
import 'package:loguin_flutter/screens/screens.dart';
import 'package:loguin_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToke(),
            builder: (BuildContext context, AsyncSnapshot<String> snapchot) {
              if (!snapchot.hasData) return Text('Espere');
              if (snapchot.data == '') {
                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
                });
              
              }else{
                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
                });
              }

             
              return Container();
            }),
      ),
    );
  }
}
