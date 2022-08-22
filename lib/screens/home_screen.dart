import 'package:flutter/material.dart';
import 'package:loguin_flutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      //que la lista se vaya construyendo
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => 
        //para cuando se le de a cualquier lado de la trahea vaya a product card
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard())
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){},
          child: Icon(Icons.add), ),
      );
  }
}