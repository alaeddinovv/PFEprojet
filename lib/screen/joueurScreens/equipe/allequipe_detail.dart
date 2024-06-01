import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class AllEquipeDetailsScreen extends StatefulWidget {
  final EquipeData equipes;
  final bool vertial;

  AllEquipeDetailsScreen(
      {super.key, required this.equipes, required this.vertial});

  @override
  State<AllEquipeDetailsScreen> createState() => _AllEquipeDetailsScreenState();
}

class _AllEquipeDetailsScreenState extends State<AllEquipeDetailsScreen> {
  bool isRequestSent = false;

  @override
  void initState() {
    super.initState();
    // Check if the player ID is in the attenteJoueursDemande list
    isRequestSent = widget.equipes.attenteJoueursDemande.any((element) =>
        element.joueur.id == HomeJoueurCubit.get(context).joueurModel!.id);
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            await EquipeCubit.get(context).getAllEquipe(
                capitanId: HomeJoueurCubit.get(context).joueurModel!.id!,
                vertial: widget.vertial);
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détail de l\'équipe'), // Display team name
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${widget.equipes.nom}',
                  // Display team name at the top of the page
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: greenConst),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: greenConst,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      widget.equipes.capitaineId.username,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Capitaine'),
                    trailing: IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        if (widget.equipes.capitaineId.telephone != null) {
                          _makePhoneCall(
                              widget.equipes.capitaineId.telephone.toString());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No telephone number available."),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Players:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.equipes.joueurs.length,
                  itemBuilder: (context, index) {
                    Joueurs joueur = widget.equipes.joueurs[index];
                    return _buildJoueurItem(
                        index, joueur.username, joueur.telephone);
                  },
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<EquipeCubit, EquipeState>(
                listener: (context, state) {
                  if (state is DemandeRejoindreEquipeStateGood ||
                      state is AnnulerRejoindreEquipeStateGood) {
                    setState(() {
                      isRequestSent = !isRequestSent; // Toggle request state
                    });
                  } else if (state is ErrorState) {
                    showToast(
                        msg: state.errorModel.message!,
                        state: ToastStates.error);
                  }
                },
                builder: (context, state) {
                  bool alreadyExists = widget.equipes.attenteJoueurs.any(
                        (joueur) =>
                            joueur.id ==
                            HomeJoueurCubit.get(context).joueurModel!.id,
                      ) ||
                      widget.equipes.joueurs.any(
                        (joueur) =>
                            joueur.id ==
                            HomeJoueurCubit.get(context).joueurModel!.id,
                      );

                  return defaultSubmit2(
                    text: isRequestSent
                        ? 'Annuler demande'
                        : 'Demander rejoindre équipe',
                    background: Colors.blueAccent,
                    onPressed: () {
                      if (alreadyExists) {
                        showToast(
                            msg: 'Vous êtes déjà dans cette équipe',
                            state: ToastStates.error);
                        return;
                      }
                      if (!isRequestSent) {
                        EquipeCubit.get(context)
                            .demanderRejoindreEquipe(id: widget.equipes.id);
                      } else {
                        EquipeCubit.get(context)
                            .annulerRejoindreEquipe(id: widget.equipes.id);
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
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: greenConst,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Joueur'),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () {
                if (telephone != null) {
                  _makePhoneCall(telephone.toString());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No telephone number available."),
                    ),
                  );
                }
              },
            ),
          ),
        ));
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
