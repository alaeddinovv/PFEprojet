import 'package:flutter/material.dart';
import 'package:pfeprojet/Model/houssem/equipe_model.dart';

class EquipeReserveDetials extends StatelessWidget {
  final EquipeModelData equipe;

  const EquipeReserveDetials({Key? key, required this.equipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipe Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${equipe.nom}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Vertical: ${equipe.vertial}'),
            const SizedBox(height: 10),
            Text('Number of Players: ${equipe.numeroJoueurs}'),
            const SizedBox(height: 20),
            const Text(
              'Players:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: equipe.joueurs?.length ?? 0,
              itemBuilder: (context, index) {
                final joueur = equipe.joueurs![index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(joueur.nom ?? ''),
                  subtitle: Text('Username: ${joueur.username}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
