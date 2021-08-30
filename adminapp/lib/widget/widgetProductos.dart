import 'package:adminapp/models/model.dart';
import 'package:adminapp/pages/detalleproductos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WidgetProductos extends StatelessWidget {
  final List<ProductosModelos> p;

  const WidgetProductos({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetalleProducots(
                            id: p[index].id, name: p[index].name)));
              },
              child: Container(
                child: Text(p[index].name.toString()),
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
