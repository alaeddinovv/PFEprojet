import 'package:flutter/material.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Reservation',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
