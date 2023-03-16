import 'dart:convert';

class ColumnaModel {
  ColumnaModel({
    required this.id,
    required this.nombreColum,
  });

  int id;
  String nombreColum;

  factory ColumnaModel.fromJson(String str) =>
      ColumnaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ColumnaModel.fromMap(Map<String, dynamic> json) => ColumnaModel(
        id: json["id"],
        nombreColum: json["nombre_colum"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre_colum": nombreColum,
      };
}
