import 'package:flutter/material.dart';
import 'package:loguin_flutter/models/models.dart';
import 'package:loguin_flutter/screens/screens.dart';
import 'package:loguin_flutter/services/services.dart';
import 'package:loguin_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

//La pantalla  que muestra los prodyctos
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Cuano se llama se trae la base de datos
    final productsSerice = Provider.of<ProductsService>(context);

    if (productsSerice.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos',),
      ),
      //que la lista se vaya construyendo
      body: ListView.builder(
          itemCount: productsSerice.products.length,
          itemBuilder: (BuildContext context, int index) =>
              //para cuando se le de a cualquier lado de la tarjea vaya a product card
              GestureDetector(
                  onTap: () {
                    //aca manda el producto seleccionado en el home
                    productsSerice.selectedProduct =
                        productsSerice.products[index].copy();
                    Navigator.pushNamed(context, 'product');
                  },
                  child: ProductCard(
                    product: productsSerice.products[index],
                  )
                )
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //para que se vea como si se huniera seleccionado un poridtco pero no tiene nada
          productsSerice.selectedProduct =
              new Products(
                available: true, 
                name: '', 
                price: 0
              );
          Navigator.pushNamed(context, 'product');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
