import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/profile.dart';

class HomeJoueur extends StatelessWidget {
  const HomeJoueur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeJouer'),
        actions: [
          TextButton(
              onPressed: () {
                navigatAndReturn(context: context, page: const ProfileJoueur());
              },
              child: const Text("Profile"))
        ],
      ),
    );
  }
}
