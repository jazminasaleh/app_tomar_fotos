import 'package:flutter/material.dart';

//* la tarjeta del login
class CardContainer extends StatelessWidget {
  //por si se le quiere cambiar algo a la tarjeta o agragra algo
  final Widget child;

  const CardContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _createCradShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCradShape() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            //la sombra de la tarjeta del login
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 8),
            )
          ]);
}
