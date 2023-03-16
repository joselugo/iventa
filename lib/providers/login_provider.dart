import 'package:flutter/material.dart';
import 'package:iventa/providers/providers.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String user = '';
  String pass = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool isLogged = false;

  Future<void> login(String user, String password) async {
    final db = await DBProvider.db.database;
    final res = await db!.query('users',
        where: 'user = ? AND password = ?', whereArgs: [user, password]);
    if (res.isNotEmpty) {
      isLogged = true;
    } else {
      isLogged = false;
      throw Exception('Usuario o contraseña incorrectos');
    }
  }
}
