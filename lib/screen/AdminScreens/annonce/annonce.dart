import 'package:flutter/material.dart';

class Annonce extends StatelessWidget {
  const Annonce({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Annonce',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
