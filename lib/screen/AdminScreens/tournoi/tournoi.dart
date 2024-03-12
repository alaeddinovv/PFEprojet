import 'package:flutter/material.dart';

class Tournoi extends StatelessWidget {
  const Tournoi({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tournoi',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
