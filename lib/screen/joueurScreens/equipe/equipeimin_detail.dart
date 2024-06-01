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

  EquipeImInDetailsScreen({super.key, required this.equipeImInData});

  @override
  State<EquipeImInDetailsScreen> createState() =>
      _EquipeImInDetailsScreenState();
}

class _EquipeImInDetailsScreenState extends State<EquipeImInDetailsScreen> {
  // bool isRequestSent = false;

  @override
  void initState() {
    super.initState();
    // Check if the player ID is in the attenteJoueursDemande list
    // isRequestSent = widget.equipeImInData.attenteJoueursDemande.any((joueur) => joueur.id == HomeJoueurCubit.get(context).joueurModel!.id);
  }

  @override
  Widget build(BuildContext context) {
    final joueurId = HomeJoueurCubit.get(context).joueurModel!.id;
    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            // await EquipeCubit.get(context).getAllEquipe();
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Détail de l\'équipe'), // Display team name
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Equipe : ${widget.equipeImInData.nom}', // Display team name at the top of the page
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity, // Match the width of the ListView
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Capitaine : ${widget.equipeImInData.capitaineId.username}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        if (widget.equipeImInData.capitaineId.telephone !=
                            null) {
                          _makePhoneCall(widget
                              .equipeImInData.capitaineId.telephone
                              .toString());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No telephone number available."),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Players:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.equipeImInData.joueurs.length,
                  itemBuilder: (context, index) {
                    Joueurs joueur = widget.equipeImInData.joueurs[index];
                    return _buildJoueurItem(
                        index, joueur.username, joueur.telephone);
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
                        msg: "equipe quiter avec succes",
                        state: ToastStates.success);
                    EquipeCubit.get(context)
                        .getAllEquipe(
                            cursor: "",
                            capitanId:
                                HomeJoueurCubit.get(context).joueurModel!.id!)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeJoueur()),
                        (route) => false,
                      );
                    });
                  } else if (state is QuiterEquipeStateBad) {
                    showToast(msg: "ressayer", state: ToastStates.error);
                  } else if (state is ErrorState) {
                    String errorMessage = state.errorModel.message!;
                    showToast(msg: errorMessage, state: ToastStates.error);
                  }
                },
                builder: (context, state) {
                  return defaultSubmit2(
                    text: 'Quitter equipe',
                    background: Colors.blueAccent,
                    onPressed: () {
                      // EquipeCubit.get(context).quiterEquipe(id: widget.equipeImInData.id, joueurId: joueurId);
                      if (joueurId != null) {
                        // Check if joueurId is not null
                        EquipeCubit.get(context).quiterEquipe(
                            equipeId: widget.equipeImInData.id,
                            joueurId: joueurId);
                      } else {
                        // Handle the error state here if joueurId is null
                        showToast(msg: "ressayer", state: ToastStates.error);
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

  Widget _buildJoueurItem(int index, String username, int? telephone) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(username, style: TextStyle(fontSize: 16)),
            ),
            Spacer(),
          ],
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
