import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loguin_flutter/providers/product_form_provider.dart';
import 'package:loguin_flutter/services/services.dart';
import 'package:loguin_flutter/ui/input_decorations.dart';
import 'package:loguin_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    //como esta es la unica pagian donde se necesita el produtco seleccioando
    //por eso se coloca aca
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectedProduct),
        child: _ProductsSceenBody(productService: productService)
      );
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
      //cuando salga el teclado el card del formulario
      body: SingleChildScrollView(
        //que la persona toque o deliqze la pantalla y se quite el teclado
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            //para que los iconos quede encima de la imagen
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
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 100);

                          if (pickedFile == null) return;
                          
                          print('Tenemos imagen ${pickedFile.path}');
                          productService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                          
                        ),
                        )
                      ),
                  Positioned(
                    top: 60,
                    right: 65,
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          if (pickedFile == null) {
                            print('no selecciono nada');
                            return;
                          }
                          print('Tenemos imagen ${pickedFile.path}');
                          
                          productService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(
                          Icons.photo_size_select_actual_outlined,
                          size: 40,
                          color: Colors.white,
                        )
                      )
                    )
              ],
            ),
            _ProductFrom(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
        ? CircularProgressIndicator(color: Colors.white,)
        : Icon(Icons.save),
        onPressed: productService.isSaving
        ? null
        :() async {
          if (!productForm.isValidForm()) return;
          final String? imageUrl = await productService.uploadImage();
          print(imageUrl);
          if ( imageUrl != null ) productForm.product.picture = imageUrl;
          await productService.saveOrcreateProduct(productForm.product);
        },
      ),
    );
  }
}

//la parte del formulario
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
                //el cuadro de texto para escribi el nombre
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 2)
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

//la decoracion de formulario
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
          ]
    );
}
