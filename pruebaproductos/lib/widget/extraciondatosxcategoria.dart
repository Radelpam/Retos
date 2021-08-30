import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pruebaproductos/model/model.dart';

class DetalleCategorias extends StatelessWidget {
  int id;

  DetalleCategorias({required this.id});

  @override
  build(BuildContext context) {
    var dataName = [];

    // ignore: cancel_subscriptions
    var users = FirebaseFirestore.instance
        .collection('Telefonos')
        .where('Categoria', isEqualTo: 1)
        .snapshots()
        .listen((event) {
      event.docs.forEach((doc) async {
        var v = dataName.add(doc['name']);
        return v;
      });
    });

    funtion('Categoria', 'Telefonos', dataName, 'name', id);

    print(dataName);

    return ListView.builder(
      itemCount: dataName.length,
      itemBuilder: (context, index) {
        return Text(dataName[index]);
      },
    );
  }

  funtion(String type, String coleccion, var data, String dataType,
      var idtype) async {
    // ignore: cancel_subscriptions, unused_local_variable
    var users = FirebaseFirestore.instance
        .collection(coleccion)
        .where(type, isEqualTo: idtype)
        .snapshots()
        .listen((event) {
      event.docs.forEach((doc) async {
        var v = await data.add(doc[dataType]);
        return v;
      });
    });
  }
}
