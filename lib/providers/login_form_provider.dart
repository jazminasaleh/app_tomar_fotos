import 'package:flutter/material.dart';
//changeBotifier es lo que permite que esta clase pueda ser colocada dentro de 
//un changenotifier provider o un multiprovider
class LoginFormprovider extends ChangeNotifier {
  //este es de tipo formstate ya que el key va a estar dentro del form
  //en login screen
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
//si el formulario es valido
  bool isValidForm() {
    print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }
}
