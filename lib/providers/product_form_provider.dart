import 'package:flutter/material.dart';
import 'package:loguin_flutter/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Products product;
  //constrcutor y el producto que recibe es importante que sea una copia
  //para que solo tenga un pordutco el seleccionado y no todos
  ProductFormProvider(this.product);
//para ver si el producto se encunetra dispoisble o no
  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }
//la informacion del porducto seleccionado
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
