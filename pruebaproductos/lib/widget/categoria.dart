import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebaproductos/model/model.dart';
import 'package:pruebaproductos/pages/detallecategorias.dart';
import 'package:pruebaproductos/provider/controller_busqueda.dart';
import 'package:pruebaproductos/widget/searchwidget.dart';

class WigetCategorias extends StatelessWidget {
  final List<CategoriaModelos> p;

  final searchCTRL = Get.put(SearchController());

  WigetCategorias({required this.p});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: p.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetalleXCategoria(
                          categoria: p[index].id!,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(p[index].name.toString()),
            ),
          ),
        );
      },
    );
  }
}
