import 'package:adminapp/models/model.dart';
import 'package:adminapp/pages/nuevoproducto.dart';
import 'package:adminapp/provider/provider.dart';
import 'package:adminapp/widget/widgetProductos.dart';
import 'package:flutter/material.dart';

class PagePrincipal extends StatefulWidget {
  const PagePrincipal({Key? key}) : super(key: key);

  @override
  _PagePrincipalState createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NuevoProdcutos()));
              },
              child: Icon(Icons.add))
        ],
        title: Text('Admin Panel'),
      ),
      body: Center(
          child:
              RefreshIndicator(onRefresh: refreshProductos, child: _listpro())),
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
}
