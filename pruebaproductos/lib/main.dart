import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pruebaproductos/pages/productos.dart';
import 'package:pruebaproductos/pages/pruebaappbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: ProductosPage());
  }
}
