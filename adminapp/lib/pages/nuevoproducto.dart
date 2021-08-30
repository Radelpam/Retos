import 'dart:io';

import 'package:adminapp/pages/principal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NuevoProdcutos extends StatefulWidget {
  @override
  _NuevoProdcutosState createState() => _NuevoProdcutosState();
}

class _NuevoProdcutosState extends State<NuevoProdcutos> {
  bool showPassword = false;
  final _name = TextEditingController();
  final _categoria = TextEditingController();
  final _profile = TextEditingController();
  final _descripcion = TextEditingController();
  final _price = TextEditingController();

  var imageUrl;

  final _formKey = GlobalKey<FormState>();

  String? textValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este espacio no puede estar vacio...'
        : null;
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection('Telefonos');

  Future<void> addUser(String categoria, String name, String descripcion,
      int price, String profile) async {
    // Call the user's CollectionReference to add a new user
    print("=============================================================");
    print(name);
    print("=============================================================");

    var ref = users.doc();
    var docref = await ref
        .set({
          'Categoria': 1,
          'name': name,
          'picture': profile,
          'available': true, // John Doe
          'descripcion': descripcion,
          'id': ref.id,
          'price': price,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return docref;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir un nuevo producto'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              (imageUrl != null)
                  ? Image.network(imageUrl)
                  : Placeholder(
                      fallbackHeight: 200.0,
                      fallbackWidth: double.infinity,
                    ),
              inputFile(
                  control: _name,
                  isPasswordTextField: false,
                  label: 'Nombre del producto',
                  number: TextInputType.name,
                  valor: textValidator),
              inputFile(
                  control: _descripcion,
                  isPasswordTextField: false,
                  label: 'Descripcion del producto',
                  number: TextInputType.text,
                  valor: textValidator),
              inputFile(
                  control: _price,
                  isPasswordTextField: false,
                  label: 'Precio del producto (USD)',
                  number: TextInputType.number,
                  valor: textValidator),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        addUser(_categoria.text, _name.text, _descripcion.text,
                            int.parse(_price.text), 'Sin Foto');

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => PagePrincipal()));
                      }
                    },
                    child: Container(
                      child: Text('Crear'),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130),
                child: ElevatedButton(
                  onPressed: () => uploadimage(),
                  child: Text('Subir imagen'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadimage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;
    // ignore: deprecated_member_use
    image = await _picker.getImage(source: ImageSource.gallery);
    //Autorizar permisos
    if (image != null) {
      var file = File(image.path);

      try {
        await _storage.ref().putFile(file);
        //Upload firebase
        var snapshot = await _storage.ref().putFile(file);

        var dowloandUrl = await snapshot.ref.getDownloadURL();
        print(dowloandUrl);
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print(e);
      }
    } else {
      print("============Mi kuka pa usted===============");
    }

    // ignore: unnecessary_null_comparison
  }

  Widget inputFile({label, control, valor, isPasswordTextField, number}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autofocus: true,
          keyboardType: number,
          validator: valor,
          controller: control,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
