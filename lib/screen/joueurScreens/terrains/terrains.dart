import 'package:flutter/material.dart';

class Terrain extends StatelessWidget {
  const Terrain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Terrain',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
