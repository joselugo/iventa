import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:iventa/models/models.dart';

class DBProvider {
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'iventa.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(''' CREATE TABLE users(
          id INTEGER PRIMARY KEY, user TEXT, password TEXT
        ); ''');
        await db.insert('users',
            UserModel(id: 1, user: 'Admin', password: 'Admin123').toMap());

        await db.execute(''' CREATE TABLE colum(
          id INTEGER PRIMARY KEY, nombre_colum TEXT
        ); ''');

        await db.insert(
            'colum', ColumnaModel(id: 1, nombreColum: 'To Do').toMap());
        await db.insert(
            'colum', ColumnaModel(id: 2, nombreColum: 'In Progress').toMap());
        await db.insert(
            'colum', ColumnaModel(id: 3, nombreColum: 'In Stop').toMap());
        await db.insert(
            'colum', ColumnaModel(id: 4, nombreColum: 'Done').toMap());

        await db.execute(''' CREATE TABLE task(
          id INTEGER PRIMARY KEY, nombre_task TEXT, tag TEXT, column_id INTEGER,
           FOREIGN KEY (column_id) REFERENCES colum(id)
        ); ''');
        await db.insert(
            'task',
            TaskModel(
                    id: 1,
                    nombreTask: 'Llamada Agendada',
                    tag: 'todo',
                    column_id: 1)
                .toMap());
        await db.insert(
            'task',
            TaskModel(
                    id: 2,
                    nombreTask: 'Interesado',
                    tag: 'progress',
                    column_id: 1)
                .toMap());
        await db.insert(
            'task',
            TaskModel(
                    id: 3,
                    nombreTask: 'Requiere Factura',
                    tag: 'done',
                    column_id: 4)
                .toMap());
      },
    );
  }

  Future<int> newUser(UserModel user) async {
    final db = await database;
    final res = await db!.insert('users', user.toMap());
    return res;
  }
}
