import 'package:flutter/material.dart';
import 'package:loguin_flutter/screens/screens.dart';
import 'package:loguin_flutter/services/product_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());
//Estado de la app 
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //crea un instancia de productservice
          create: (_)=>ProductsService(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login'   : (_) => LoginScreen(),
        'home'    : (_) => HomeScreen(),
        'product' : (_) => ProductScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
