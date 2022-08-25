import 'package:flutter/material.dart';
import 'package:loguin_flutter/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Products product;
  //constrcutor
  ProductFormProvider(this.product);
//para ver si el producto se encunetra dispoisble
  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
     print(product.name);
     print(product.price);
    return formKey.currentState?.validate() ?? false;
  }
}
