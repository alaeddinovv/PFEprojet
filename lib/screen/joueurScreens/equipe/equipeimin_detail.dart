import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class EquipeImInDetailsScreen extends StatefulWidget {
  final EquipeData equipeImInData;

  EquipeImInDetailsScreen({Key? key, required this.equipeImInData})
      : super(key: key);

  @override
  State<EquipeImInDetailsScreen> createState() =>
      _EquipeImInDetailsScreenState();
}

class _EquipeImInDetailsScreenState extends State<EquipeImInDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final joueurId = HomeJoueurCubit.get(context).joueurModel!.id;
    bool canPop = true;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop && canPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détail de l\'équipe'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.equipeImInData.nom,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Capitaine: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.equipeImInData.capitaineId.username,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        _makePhoneCall(widget
                            .equipeImInData.capitaineId.telephone
                            .toString());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Players:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.equipeImInData.joueurs.length,
                  itemBuilder: (context, index) {
                    Joueurs joueur = widget.equipeImInData.joueurs[index];
                    return _buildJoueurItem(
                        index, joueur.username, joueur.telephone, joueur.photo);
                  },
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<EquipeCubit, EquipeState>(
                listener: (context, state) {
                  if (state is QuiterEquipeLoadingState) {
                    canPop = false;
                  } else {
                    canPop = true;
                  }
                  if (state is QuiterEquipeStateGood) {
                    showToast(
                      msg: "Equipe quittée avec succès",
                      state: ToastStates.success,
                    );
                    EquipeCubit.get(context)
                        .getAllEquipe(
                      cursor: "",
                      capitanId: HomeJoueurCubit.get(context).joueurModel!.id!,
                    )
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeJoueur()),
                        (route) => false,
                      );
                    });
                  } else if (state is QuiterEquipeStateBad) {
                    showToast(msg: "Réessayez", state: ToastStates.error);
                  } else if (state is ErrorState) {
                    String errorMessage = state.errorModel.message!;
                    showToast(msg: errorMessage, state: ToastStates.error);
                  }
                },
                builder: (context, state) {
                  return defaultSubmit2(
                    text: 'Quitter équipe',
                    background: Colors.blueAccent,
                    onPressed: () {
                      if (joueurId != null) {
                        EquipeCubit.get(context).quiterEquipe(
                          equipeId: widget.equipeImInData.id,
                          joueurId: joueurId,
                        );
                      } else {
                        showToast(msg: "Réessayez", state: ToastStates.error);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJoueurItem(
      int index, String username, int? telephone, String? photo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          height: 75,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: photo != null
                        ? NetworkImage(photo)
                        : const AssetImage('assets/images/football.png')
                            as ImageProvider<Object>,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Joueur'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
      await launchUrl(launchUri);
    } else {
      print('Permission denied');
    }
  }
}
