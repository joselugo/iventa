import 'package:flutter/material.dart';
import 'package:iventa/providers/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 200),
                CardContainer(
                    child: Column(
                  children: [
                    const Text(
                      'Inisiar Sesion',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginProvider(),
                      child: const LoginForm(),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
