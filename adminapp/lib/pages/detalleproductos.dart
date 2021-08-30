import 'package:adminapp/pages/principal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetalleProducots extends StatefulWidget {
  //TODO: Datos que deseas ver y editar dentro de la pagina de detalle productos
  String id;
  String name;

  DetalleProducots({required this.id, required this.name});

  @override
  _DetalleProducotsState createState() => _DetalleProducotsState();
}

class _DetalleProducotsState extends State<DetalleProducots> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('Telefonos');

  final _name = TextEditingController();
  final _categoria = TextEditingController();
  final _profile = TextEditingController();
  final _descripcion = TextEditingController();
  final _price = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> deleteUser() {
    return users
        .doc(widget.id)
        .delete()
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => PagePrincipal())))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateUser(String actualizacion, String nuevotexto) {
    return users
        .doc(widget.id)
        .update({actualizacion: nuevotexto})
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => PagePrincipal())))
        .catchError((error) => print("Failed to update user: $error"));
  }

  String? textValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este espacio no puede estar vacio...'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    deleteUser();
                  },
                  child: Container(
                    child: Text('Borrar Documento'),
                  )),
            ),
            inputFile(
                control: _name,
                isPasswordTextField: false,
                label: 'Nombre del producto',
                number: TextInputType.name,
                valor: textValidator,
                hint: widget.name),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      updateUser('name', _name.text);
                    }
                  },
                  child: Container(
                    child: Text('Actualizar nomnbre del producto'),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget inputFile({label, control, valor, isPasswordTextField, number, hint}) {
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
              hintText: hint,
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
