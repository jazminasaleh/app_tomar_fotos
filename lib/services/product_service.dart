import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:loguin_flutter/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:loguin_flutter/widgets/product_card.dart';

//se trae la informacion de la base de datos
//y esa infrmoarcion es almacenada en la lista products
//Se maneja changeNotifier ya que se va a menjar porvider(gestor de estado)
class ProductsService extends ChangeNotifier {
  //la primera parte del link de postamn desde // hasta el slash /
  final String _baseUrl = 'flutter-varios-66e14-default-rtdb.firebaseio.com';
  //aca se almacenaran todos los productos
  final List<Products> products = [];
  //el porducto seleccionado en el home
  late Products selectedProduct;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;
//constructor
//Siempre que se llame a esta clase que cargue los productos
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
    //Se agrega a products los productos que estan en la base de datos
    //se agrega id al producto
    productsMap.forEach((key, value) {
      final tempProduct = Products.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

      this.isLoading = false;
      notifyListeners();
      return this.products;
  }

//crea o actualiza el producto
  Future saveOrcreateProduct(Products product) async {
    //Esta gurdado o creado
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
      //es necesraio crera un nuevo producto
      createProduct(product);
    } else {
      //actaulizacion de la infromacion del producto
      await this.updateProduct(product);
    }
    //no esta guraddo o creaod
    isSaving = false;
    notifyListeners();
  }

//actualizar informacion del producto
  Future<String> updateProduct(Products product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final descodeData = resp.body;
    print(descodeData);
    for (var i = 0; i < products.length; i++) {
      if (products[i].id == product.id) {
        this.products[i] = product;
      }
    }
    return product.id!;
  }

//crera un nuevo producto
  Future<String> createProduct(Products product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final descodeData = json.decode(resp.body);
    product.id = descodeData['name'];
    this.products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dbzsnembj/image/upload?upload_preset=rxyl54nc');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
