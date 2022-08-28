import 'dart:io';
import 'package:flutter/material.dart';

//Mostrar la imagen en la pantalla product
class ProductIamge extends StatelessWidget {
  final String? url;

  const ProductIamge({super.key, this.url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        //colocar a la imagen una opacidad para que se vea la camara
        child: Opacity(
          opacity: 0.8,
          //para agregar bordes redondeados 
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(url)
            ),
        ),
      ),
    );
  }
//decoracion de la imagen
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Color.fromARGB(255, 9, 9, 9),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);
  
  //obtener la imagen tomada de galeria o por camara
  //y mostrarla
  Widget getImage(String? picture) {
    if (picture == null)
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );

    if (picture.startsWith('http')) {
      return FadeInImage(
        image: NetworkImage(this.url!),
        placeholder: AssetImage('assets/jar-loading.gif'),
        //para que la imagen tome todo el espacio del container
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
