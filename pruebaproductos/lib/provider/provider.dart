import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebaproductos/model/model.dart';

class ProductosProvider {
  var productos =
      FirebaseFirestore.instance.collection('Telefonos').orderBy('id');
  var categorias =
      FirebaseFirestore.instance.collection('Categorias').orderBy('id');

  Future<List<ProductosModelos>> _procesarProducto() async {
    List<ProductosModelos> productop = [];
    var ppro = await productos.get();

    ppro.docs.forEach((doc) {
      productop.add(ProductosModelos.fromJsonMap(doc.data()));
    });

    return productop;
  }

  Future<List<CategoriaModelos>> _procesarCategoria() async {
    List<CategoriaModelos> categoriap = [];
    var ppro = await categorias.get();

    ppro.docs.forEach((doc) {
      categoriap.add(CategoriaModelos.fromJsonMap(doc.data()));
    });

    return categoriap;
  }

  Future<List<CategoriaModelos>> getCategoria() async {
    return await _procesarCategoria();
  }

  Future<List<ProductosModelos>> getProductos() async {
    return await _procesarProducto();
  }
}
