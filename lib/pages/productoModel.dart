class ProductoDataModel {
  int? id;
  String? nombre;
  int? precio;
  String? imagenURL;

  ProductoDataModel(
      {
        this.id,
        this.nombre,
        this.precio,
        this.imagenURL
      });

  ProductoDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    nombre = json['nombre'];
    precio = json['precio'];
    imagenURL = json['imagenURL'];
  }
}
