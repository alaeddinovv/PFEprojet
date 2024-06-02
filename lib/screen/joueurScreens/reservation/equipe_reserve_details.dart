import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/houssem/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';

class EquipeReserveDetials extends StatelessWidget {
  final EquipeModelData equipe;

  const EquipeReserveDetials({Key? key, required this.equipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipe Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Text(
              'Equipe Name: ${equipe.nom ?? 'Unknown Team'}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              child: ListTile(
                leading: Icon(Icons.people, color: greenConst),
                title: Text('Number of players: ${equipe.numeroJoueurs}'),
                subtitle: const Text('Team Size'),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Captain',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Card(
              child: ListTile(
                leading: Icon(Icons.star, color: greenConst),
                title: Text(equipe.capitaineId!.username!),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Players',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Card(
              child: Column(
                children: equipe.joueurs!.map((joueur) {
                  return ListTile(
                    leading: Icon(Icons.person, color: greenConst),
                    title: Text(joueur.username!),
                  );
                }).toList(),
              ),
            ),
            if (equipe.attenteJoueurs!.isNotEmpty) ...[
              const SizedBox(height: 20.0),
              const Text(
                'Pending Players',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Card(
                child: Column(
                  children: equipe.attenteJoueurs!.map((joueur) {
                    return ListTile(
                      leading: Icon(Icons.person, color: greenConst),
                      title: Text(joueur.username!),
                      trailing: const Icon(Icons.hourglass_empty),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 20.0),
            Card(
              child: ListTile(
                leading: Icon(Icons.location_on, color: greenConst),
                title: Text('${equipe.wilaya}, ${equipe.commune}'),
                subtitle: const Text('Location'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            BlocConsumer<EquipeCubit, EquipeState>(
              listener: (context, state) {
                if (state is AnnulerRejoindreEquipeStateGood) {
                  Navigator.pop(context);
                }
                if (state is ErrorState) {
                  showToast(
                      msg: state.errorModel.message!, state: ToastStates.error);
                }
              },
              builder: (context, state) {
                if (state is AnnulerRejoindreEquipeLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return defaultSubmit2(
                  text: 'Annuler demande',
                  onPressed: () {
                    EquipeCubit.get(context)
                        .annulerRejoindreEquipe(id: equipe.id!);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
