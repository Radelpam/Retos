class ModelProdcuto {
  List<ProductosModelos> items = [];

  ModelProdcuto();

  ModelProdcuto.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final productosmodel = new ProductosModelos.fromJsonMap(item);
      items.add(productosmodel);
    }
  }
}

class ModelCategoria {
  List<CategoriaModelos> items = [];

  ModelCategoria();

  ModelCategoria.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final categoriamodel = new CategoriaModelos.fromJsonMap(item);
      items.add(categoriamodel);
    }
  }
}

class CategoriaModelos {
  int? id;
  String? name;

  CategoriaModelos({required this.id, required this.name});

  CategoriaModelos.fromJsonMap(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}

class ProductosModelos {
  late int categoria;
  late bool available;
  late String descripcion;
  late String id;
  late String name;
  late String picture;
  late int price;

  ProductosModelos(
      {required this.categoria,
      required this.available,
      required this.descripcion,
      required this.id,
      required this.name,
      required this.picture,
      required this.price});

  ProductosModelos.fromJsonMap(dynamic json) {
    categoria = json['Categoria'];
    available = json['available'];
    descripcion = json['descripcion'];
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    price = json['price'];
  }
}
