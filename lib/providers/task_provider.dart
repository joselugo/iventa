import 'package:flutter/material.dart';
import 'package:iventa/providers/db_provider.dart';
import '../models/models.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

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

  Future<void> addTask(TaskModel task) async {
    final db = await DBProvider.db.database;
    await db!.insert('tasks', task.toMap());
    await fetchTasks();
  }

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
