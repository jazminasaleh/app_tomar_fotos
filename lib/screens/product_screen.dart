import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loguin_flutter/providers/product_form_provider.dart';
import 'package:loguin_flutter/services/services.dart';
import 'package:loguin_flutter/ui/input_decorations.dart';
import 'package:loguin_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectedProduct),
        child: _ProductsSceenBody(productService: productService));
  }
}

class _ProductsSceenBody extends StatelessWidget {
  const _ProductsSceenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        //que la persona toque o deliqze la pantalla y se quite el teclado
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductIamge(
                  url: productService.selectedProduct.picture,
                ),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        )))
              ],
            ),
            _ProductFrom(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (!productForm.isValidForm()) return;
          productService.saveOrcreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductFrom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'el nombre es obligatorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre:'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: product.price.toString(),
                  //solo acepta numeros
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', labelText: 'Precio:'),
                ),
                SizedBox(
                  height: 30,
                ),
                SwitchListTile(
                    value: product.available,
                    title: Text('Disponible'),
                    activeColor: Colors.indigo,
                    onChanged: productForm.updateAvailability)
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
