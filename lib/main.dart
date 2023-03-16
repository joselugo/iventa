import 'package:flutter/material.dart';
import 'package:iventa/screens/screens.dart';
import 'package:iventa/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColumnaProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iVenta Test',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
