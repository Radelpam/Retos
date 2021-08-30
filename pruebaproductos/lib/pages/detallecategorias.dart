import 'package:flutter/material.dart';
import 'package:pruebaproductos/model/model.dart';
import 'package:pruebaproductos/provider/provider.dart';
import 'package:pruebaproductos/widget/extraciondatosxcategoria.dart';

class DetalleXCategoria extends StatefulWidget {
  int categoria;

  DetalleXCategoria({required this.categoria});

  @override
  State<DetalleXCategoria> createState() => _DetalleXCategoriaState();
}

class _DetalleXCategoriaState extends State<DetalleXCategoria> {
  final pProvider = new ProductosProvider();
  Future<void> refreshProductos() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _listpro();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categoria'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshProductos,
        child: DetalleCategorias(
          id: widget.categoria,
        ),
      ),
    );
  }

  Widget _listpro() {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<ProductosModelos>>(
        future: pProvider.getProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductosModelos>> snapshot) {
          if (snapshot.hasData) {
            return DetalleCategorias(
              id: widget.categoria,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
