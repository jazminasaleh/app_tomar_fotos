import 'package:flutter/material.dart';
import 'package:loguin_flutter/models/models.dart';

//Para hacer las tarjetas que se ven en la pnatalla home
class ProductCard extends StatelessWidget {
  //ahi estan almacendaos los valores de la base de datos
  final Products product;

  const ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        width: double.infinity,
        height: 350,
        //hacerle la decoracion al card
        decoration: _cardBorders(),
        //para poder colocar un widget encima de otro
        child: Stack(
          //para que los elementos esten en la parte de abajo
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),
            _ProductDetails(
              title: product.name,
              subtitle: product.id!,
            ),
            Positioned(
              child: _PriceTag(
                price: product.price,
              ),
              top: 0,
              right: 0,
            ),
            if (!product.available)
              Positioned(
                child: _NotAvailable(),
                top: 0,
                left: 0,
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        //para darle estilo a los bordes
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 9), blurRadius: 10)
        ]);
  }
}

//El widget de si esta disposible o no 
class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }
}

//el widget deñ precio de la parte de arriba derecha
class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      //posiciona a su hijo dentro de si mimso de acuerdo con el ajuste
      child: FittedBox(
        //para que el texto se adapte al tamaño del container y asi sea un valor grande quede todo en una sola linea
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$price',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

//Los detalles del widget de la parte de abajo de la tareja la cual tiene el precio y el id
class _ProductDetails extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ProductDetails(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 70,
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Ref $subtitle',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

//redendear los bordes de la parte de abajo
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Color.fromARGB(255, 88, 103, 187),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ));
}

//la imagen de fondo de los crads
class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    //para poder redondear el container
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 400,
        //se mira si hay imagen, por si alguno no tiene imagen
        child: url == null
            ? Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                image: NetworkImage(url!),
                placeholder: AssetImage('assets/jar-loading.gif'),
                //para que la imagen quede en todo el container
                fit: BoxFit.cover),
      ),
    );
  }
}
