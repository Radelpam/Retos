import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pruebaproductos/model/model.dart';
import 'package:pruebaproductos/provider/controller_busqueda.dart';
import 'package:pruebaproductos/provider/provider.dart';
import 'package:pruebaproductos/widget/categoria.dart';
import 'package:pruebaproductos/widget/searchwidget.dart';
import 'package:pruebaproductos/widget/widget.dart';
import 'package:get/get.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({Key? key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final pProvider = new ProductosProvider();
  final searchCTRL = Get.put(SearchController());
  var data1 = [];

  Future<void> refreshProductos() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _categorias();
      data1 = [];
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    _listtext(data1);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cliente App'),
          actions: [
            IconButton(
                onPressed: () {
                  searchCTRL.openandclosed();
                },
                icon: Icon(Icons.open_in_browser)),
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate:
                          DataSeach(productos: data1, recentProducts: data1));
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshProductos,
          child: Column(
            children: [
              SearchWidget(id: 1),
              Divider(),
              Expanded(child: _categorias()),
              Divider(),
              Expanded(child: _listpro()),
            ],
          ),
        ));
  }

  Widget _categorias() {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<CategoriaModelos>>(
        future: pProvider.getCategoria(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoriaModelos>> snapshot) {
          if (snapshot.hasData) {
            return WigetCategorias(
              p: snapshot.data!,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
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
            return WidgetProductos(
              p: snapshot.data!,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  _listtext(var data) async {
    // ignore: cancel_subscriptions
    var users = FirebaseFirestore.instance
        .collection('Telefonos')
        .where('Categoria', isEqualTo: 1)
        .snapshots()
        .listen((event) {
      event.docs.forEach((doc) async {
        print(data);
        return data.add(doc['name']);
      });
    });
  }
}

class DataSeach extends SearchDelegate<String> {
  final pProvider = new ProductosProvider();
  var productos = [];

  var recentProducts = [];

  DataSeach({required this.productos, required this.recentProducts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentProducts
        : productos.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          )),
      itemCount: suggestionList.length,
    );
  }
}
