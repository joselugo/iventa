import 'package:flutter/material.dart';
import 'package:iventa/models/models.dart';
import 'package:iventa/providers/db_provider.dart';

class ColumnaProvider with ChangeNotifier {
  final dbProvider = DBProvider.db;

  Future<List<ColumnaModel>> getColumnas() async {
    final db = await dbProvider.database;
    final res = await db!.query('colum');
    List<ColumnaModel> list =
        res.isNotEmpty ? res.map((c) => ColumnaModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<ColumnaModel?> getColumna(int id) async {
    final db = await dbProvider.database;
    final res = await db!.query('colum', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ColumnaModel.fromMap(res.first) : null;
  }

  Future<int> nuevaColumna(ColumnaModel columna) async {
    final db = await dbProvider.database;
    final res = await db!.insert('colum', columna.toMap());
    notifyListeners();
    return res;
  }

  Future<int> actualizarColumna(ColumnaModel columna) async {
    final db = await dbProvider.database;
    final res = await db!.update('colum', columna.toMap(),
        where: 'id = ?', whereArgs: [columna.id]);
    notifyListeners();
    return res;
  }

  Future<int> eliminarColumna(int id) async {
    final db = await dbProvider.database;
    final res = await db!.delete('colum', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
    return res;
  }
}
