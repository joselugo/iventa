import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../theme/app_theme.dart';

class DraweMenu extends StatelessWidget {
  const DraweMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.pages_rounded, color: AppTheme.primary),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.people_alt_rounded, color: AppTheme.primary),
            title: const Text('Usuarios'),
            onTap: () {},
          ),
          ListTile(
            leading:
                const Icon(Icons.settings_rounded, color: AppTheme.primary),
            title: const Text('Ajustes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background/menu_img.jpg'),
              fit: BoxFit.cover)),
      child: Container(),
    );
  }
}
