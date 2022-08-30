import 'package:flutter/material.dart';
import 'package:loguin_flutter/screens/screens.dart';
import 'package:loguin_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';
//Cuando se abra la app este en el login o ya en los productos
class CheckAutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToke(),
            builder: (BuildContext context, AsyncSnapshot<String> snapchot) {
              if (!snapchot.hasData) return Text('Espere porfavor!');
              //si no se tiene token que vaya al login
              if (snapchot.data == '') {
                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
                });
              //que vaya al home
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
