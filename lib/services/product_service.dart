import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:loguin_flutter/models/models.dart';
import 'package:http/http.dart' as http;
//se trae la informacion de la base de datos
//y esa infrmoarcion es almacenada en la lista products
class ProductsService extends ChangeNotifier {
  //la primera parte del link de postamn hasta el slash
  final String _baseUrl = 'flutter-varios-66e14-default-rtdb.firebaseio.com';
  final List<Products> products = [];
  bool isLoading = true;
//constructor

//Siempre que se llame a esta clase que crague los productos
  ProductsService() {
    this.loadingProducts();
  }
//para cragr los productos
  Future<List<Products>> loadingProducts() async {
    this.isLoading = true;
    notifyListeners();
    //el segundo parametro es la utlima parte del link de postamn
    final url = Uri.https(_baseUrl, 'products.json');
    //Traer la infromacion de la base de datos
    final resp = await http.get(url);
    //convertir la respuesta en un mapa
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    print(productsMap);
    //Se agrega a products los productos que estan en la base de datos
    productsMap.forEach((key, value) {
      final tempProduct = Products.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();
    return this.products;
  }
}
