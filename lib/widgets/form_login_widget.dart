import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';
import '../ui/inputs_decorations_ui.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginProvider>(context);
    bool isLoading = false;
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Admin',
                  labelText: 'Usuario',
                  prefixIcon: Icons.person),
              onChanged: (value) => loginForm.user = value,
              validator: (value) {
                String pattern = r'^[a-zA-Z0-9]+$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato incorrecto de correo';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'Contrasena',
                  prefixIcon: Icons.lock_outline_rounded),
              onChanged: (value) => loginForm.pass = value,
              validator: (value) {
                return (value != null && value.length >= 5)
                    ? null
                    : 'La contraseña debe ser mayor o igual a 5 caracteres';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: AppTheme.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () async {
                  if (!loginForm.isValidForm()) return;
                  try {
                    await loginForm.login(loginForm.user, loginForm.pass);
                    Navigator.pushReplacementNamed(context, 'home');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        AppTheme.customSnackBarFailed(
                            'Usuario o contraseña incorrectos'));
                  }
                })
          ],
        ));
  }
}
