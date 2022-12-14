import 'package:flutter/material.dart';
import 'package:loguin_flutter/providers/login_form_provider.dart';
import 'package:loguin_flutter/services/services.dart';
import 'package:loguin_flutter/ui/input_decorations.dart';
import 'package:loguin_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';


//*Pagina de resgistros

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
      children: [
        SizedBox(
          height: 250,
        ),
        CardContainer(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Crear cuenta',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 30,
            ),
            ChangeNotifierProvider(
              create: (_) => LoginFormprovider(),
              //lo que esta dentro de loginfrom es al que se le va a aplicar el provider
              child: _LoginForm(),
            )
          ],
        )),
        SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
              shape: MaterialStateProperty.all(StadiumBorder())),
          child: Text(

            '¿Ya tienes una cuenta?',

            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        SizedBox(
          height: 80,
        )
      ],
    ))));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //instancia de losginfromprovider
    final loginForm = Provider.of<LoginFormprovider>(context);
    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'jazmin.saleh@gmail.com',
                    labelText: 'Correo electronico',
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  //validacion del correo con expresiones regulares
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '******',
                    labelText: 'Contraeña',
                    prefixIcon: Icons.lock_clock_outlined),
                //se alamacena en el login from provider la contraseña
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  if (value != null && value.length >= 6) return null;
                  return 'La contraseña debe de ser 6 carcateres';
                },
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoading ? 'Espere' : 'Ingresar',
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          //quitar el teclado
                          FocusScope.of(context).unfocus();

                          //provider authservice
                          final authService =
                              Provider.of<AuthService>(context, listen: false);

                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          //el create usuario regresa:
                          // el idToekn si es valido el correo, osea no existe en la app
                          //y regresa error si no es valido el correo
                          final String? errorMessege = await authService
                              .createUser(loginForm.email, loginForm.password);
                          //si el error es null pasa a la sieguinete pantalla
                          if (errorMessege == null) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                             NotificacionesService.showSanckbar('CORREO YA ESTA RESGITRADO',  backgroundColor: Colors.indigo,  duration: const Duration(milliseconds: 1500),);
                            loginForm.isLoading = false;
                          }
                        })

            ],
          )),
    );
  }
}
