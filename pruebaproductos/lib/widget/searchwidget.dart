import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebaproductos/provider/controller_busqueda.dart';

class SearchWidget extends StatelessWidget {
  int id;

  SearchWidget({required this.id});

  final searchCTRL = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    var data = [];
    funtion('Categoria', 'Telefonos', data, 'name', id);
    return Obx(
      () => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 500,
          height: searchCTRL.heigt.value,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Text(data.toString())),
    );
  }

  funtion(
      String type, String coleccion, var data, String dataType, var idtype) {
    // ignore: cancel_subscriptions
    var users = FirebaseFirestore.instance
        .collection(coleccion)
        .where(type, isEqualTo: idtype)
        .snapshots()
        .listen((event) {
      event.docs.forEach((doc) async {
        print('=================================');
        print(doc[dataType]);
        print('=================================');
        var v = await data.add(doc[dataType]);
        return v;
      });
    });
  }
}
