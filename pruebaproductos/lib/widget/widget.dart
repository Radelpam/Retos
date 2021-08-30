import 'package:flutter/material.dart';
import 'package:pruebaproductos/model/model.dart';

class WidgetProductos extends StatelessWidget {
  final List<ProductosModelos> p;

  const WidgetProductos({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        return Container(
          child: Text(p[index].name.toString()),
        );
      },
    );
  }
}
