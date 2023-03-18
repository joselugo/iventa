import 'dart:convert';

class TaskModel {
  TaskModel({
    required this.id,
    required this.nombreTask,
    required this.tag,
    required this.column_id,
  });

  int id;
  String nombreTask;
  String tag;
  int column_id;

  //Nueva funcion
  TaskModel copyWith({
    int? id,
    String? nombreTask,
    String? tag,
    int? column_id,
  }) {
    return TaskModel(
      id: id ?? this.id,
      nombreTask: nombreTask ?? this.nombreTask,
      tag: tag ?? this.tag,
      column_id: column_id ?? this.column_id,
    );
  }
  //fin

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        nombreTask: json["nombre_task"],
        tag: json["tag"],
        column_id: json["column_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre_task": nombreTask,
        "tag": tag,
        "column_id": column_id,
      };
}
