import 'package:flutter/material.dart';
import 'package:iventa/providers/db_provider.dart';
import '../models/models.dart';

class TaskProvider extends ChangeNotifier {
  List<ColumnaModel> _columnas = [
    ColumnaModel(id: 1, nombreColum: "To Do"),
    ColumnaModel(id: 2, nombreColum: "In Progress"),
    ColumnaModel(id: 3, nombreColum: "In Stop"),
    ColumnaModel(id: 4, nombreColum: "Done"),
  ];

  List<TaskModel> _tasks = [
    TaskModel(
        id: 1, nombreTask: "Llamada Agendada", tag: "Tag 1", column_id: 1),
    TaskModel(id: 2, nombreTask: "Interesado", tag: "Tag 2", column_id: 1),
    TaskModel(
        id: 3, nombreTask: "Requiere Factura", tag: "Tag 3", column_id: 2),
  ];

  //List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  // nueva funcion
  List<ColumnaModel> get columnas => _columnas;

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void moveTask(TaskModel task, int newColumnId) {
    final index = _tasks.indexOf(task);
    if (index >= 0) {
      _tasks[index] = task.copyWith(column_id: newColumnId);
      notifyListeners();
    }
  }

  void removeTask(TaskModel task) {
    _tasks.remove(task);
    notifyListeners();
  }
  // fin

  Future<List<TaskModel>> getTasksByColumnId(int columnId) async {
    final db = await DBProvider.db.database;
    final res =
        await db!.query('task', where: 'column_id = ?', whereArgs: [columnId]);
    List<TaskModel> list =
        res.isNotEmpty ? res.map((c) => TaskModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<void> fetchTasks() async {
    final db = await DBProvider.db.database;
    final res = await db!.query('tasks');
    _tasks = res.map((task) => TaskModel.fromMap(task)).toList();
    notifyListeners();
  }

  // Future<void> addTask(TaskModel task) async {
  //   final db = await DBProvider.db.database;
  //   await db!.insert('tasks', task.toMap());
  //   await fetchTasks();
  // }

  Future<void> deleteTask(int id) async {
    final db = await DBProvider.db.database;
    await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await fetchTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await DBProvider.db.database;
    await db!
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    await fetchTasks();
  }
}
