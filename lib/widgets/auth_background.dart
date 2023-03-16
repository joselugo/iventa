import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: SizedBox(
      width: double.infinity,
      height: 200,
      // margin: const EdgeInsets.only(top: 30),
      child: Icon(Icons.person_pin, color: Colors.white, size: 100),
    ));
  }
}
