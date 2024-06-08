import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/profile_other.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure this path is correct

// ignore: must_be_immutable
class MyEquipeDetailsScreen extends StatefulWidget {
  EquipeData equipeData;
  final bool vartial;
  MyEquipeDetailsScreen(
      {super.key, required this.equipeData, required this.vartial});

  @override
  State<MyEquipeDetailsScreen> createState() => _MyEquipeDetailsScreenState();
}

class _MyEquipeDetailsScreenState extends State<MyEquipeDetailsScreen> {
  bool goProfile = false;
  @override
  Widget build(BuildContext context) {
    // Total count now uses numeroJoueurs from the equipeData
    int totalItems = widget.equipeData.numeroJoueurs;
    int joueurCount = widget.equipeData.joueurs.length;
    int attenteJoueursCount = widget.equipeData.attenteJoueurs.length;

    int joueurenattenteitems = widget.equipeData.attenteJoueursDemande.length;

    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            await EquipeCubit.get(context).getMyEquipe(vertial: widget.vartial);
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détail de l\'équipe'), // Display team name
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Text(
                //     '${widget.equipeData.nom}',
                //     // Display team name at the top of the page
                //     style: TextStyle(
                //         fontSize: 24,
                //         fontWeight: FontWeight.bold,
                //         color: greenConst),
                //   ),
                // ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Capitaine: ',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.equipeData.capitaineId.username}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<EquipeCubit, EquipeState>(
                  listener: (context, state) async {
                    // go profile for separate when i search joueur or i want to go to profile
                    if (state is CheckUserByUsernameStateGood && goProfile) {
                      goProfile = false;
                      navigatAndReturn(
                          context: context,
                          page: OtherJoueurDetails(
                              joueurModel: state.dataJoueurModel));
                    }
                    if (state is QuiterEquipeStateGood) {
                      showToast(
                          msg: "Operation successful",
                          state: ToastStates.success);
                      setState(() {
                        widget.equipeData.joueurs.removeWhere(
                            (element) => element.id == state.idJoueur);
                      });

                      EquipeCubit.get(context)
                          .getMyEquipe(vertial: widget.vartial);

                      // This should re-fetch the equipe data
                    } else if (state
                        is CapitaineAnnuleInvitationJoueurStateGood) {
                      showToast(
                          msg: "Operation successful",
                          state: ToastStates.success);
                      setState(() {
                        widget.equipeData.attenteJoueurs.removeWhere(
                            (element) => element.id == state.idJoueur);
                      });

                      EquipeCubit.get(context)
                          .getMyEquipe(vertial: widget.vartial);
                    } else if (state is CapitaineInviteJoueurStateGood) {
                      print(state.joueurId);

                      setState(() {
                        widget.equipeData.attenteJoueurs.add(AttenteJoueurs(
                          id: EquipeCubit.get(context).joueur.id!,
                          username: EquipeCubit.get(context).joueur.username!,
                          nom: EquipeCubit.get(context).joueur.nom!,
                          telephone: EquipeCubit.get(context).joueur.telephone!,
                        ));
                        showToast(
                            msg: "Player successfully invited.",
                            state: ToastStates.success);
                      });
                      await sendNotificationToJoueur(
                        joueurId: state.joueurId,
                        body: 'une equipe vous a envoyer une invitation',
                        title: 'invitation from ${state.equipename}',
                      );
                    } else if (state is QuiterEquipeStateBad ||
                        state is CapitaineAnnuleInvitationJoueurStateBad) {
                      showToast(
                          msg: "Failed to perform operation",
                          state: ToastStates.error);
                    } else if (state is ErrorState) {
                      showToast(
                          msg: state.errorModel.message!,
                          state: ToastStates.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is QuiterEquipeLoadingState ||
                        state is CapitaineAnnuleInvitationJoueurLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: totalItems, // Adjust the count as needed
                      itemBuilder: (context, index) {
                        if (index < joueurCount) {
                          Joueurs joueur = widget.equipeData.joueurs[index];
                          // print(joueur.photo);
                          return _buildJoueurItem(
                            index,
                            joueur.id,
                            widget.equipeData.id,
                            joueur.username,
                            joueur.photo,
                            joueur.telephone,
                          );
                        } else if (index < joueurCount + attenteJoueursCount) {
                          // AttenteJoueurs attentejoueur = widget.equipeData.attenteJoueurs[index - widget.equipeData.joueurs.length];
                          return _buildProgressItem(
                              index,
                              widget
                                  .equipeData
                                  .attenteJoueurs[
                                      index - widget.equipeData.joueurs.length]
                                  .id,
                              widget.equipeData.id,
                              widget
                                  .equipeData
                                  .attenteJoueurs[
                                      index - widget.equipeData.joueurs.length]
                                  .photo,
                              widget
                                  .equipeData
                                  .attenteJoueurs[
                                      index - widget.equipeData.joueurs.length]
                                  .username); // Use the new progress item for 3rd and 4th items
                        } else {
                          return _buildAddItem(index, widget.equipeData.id,
                              widget.equipeData.nom);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text('Les demandes',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                BlocConsumer<EquipeCubit, EquipeState>(
                  listener: (context, state) async {
                    if (state is CapitaineRefuseJoueurStateGood) {
                      showToast(
                          msg: "Operation successful",
                          state: ToastStates.success);
                      setState(() {
                        widget.equipeData.attenteJoueursDemande.removeWhere(
                            (element) => element.joueur.id == state.idJoueur);
                      });

                      EquipeCubit.get(context)
                          .getMyEquipe(vertial: widget.vartial);

                      // This should re-fetch the equipe data
                    } else if (state is CapitaineAceeptJoueurStateGood) {
                      await sendNotificationToJoueur(
                          joueurId: state.joueurId,
                          body: 'Vous êtes désormais un joueur de cette équipe',
                          title: '${state.equipename} a accepté votre demande');
                      setState(() {
                        // Adding the newly invited joueur to the 'attenteJoueurs' list
                        widget.equipeData.joueurs.add(Joueurs(
                          id: EquipeCubit.get(context).joueuraccepted.id!,
                          username:
                              EquipeCubit.get(context).joueuraccepted.username!,
                          nom: EquipeCubit.get(context).joueuraccepted.nom!,
                          telephone: EquipeCubit.get(context)
                              .joueuraccepted
                              .telephone!,
                        ));

                        widget.equipeData.attenteJoueursDemande.removeWhere(
                          (element) =>
                              element.joueur.id ==
                              EquipeCubit.get(context).joueuraccepted.id!,
                        );
                      });
                      showToast(
                          msg: "Player successfully added.",
                          state: ToastStates.success);
                    } else if (state is CapitaineAceeptJoueurStateBad ||
                        state is CapitaineRefuseJoueurStateBad) {
                      showToast(
                          msg: "Failed to perform operation",
                          state: ToastStates.error);
                    } else if (state is ErrorState) {
                      showToast(
                          msg: state.errorModel.message!,
                          state: ToastStates.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is CapitaineRefuseJoueurLoadingState ||
                        state is CapitaineAceeptJoueurLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount:
                          joueurenattenteitems, // Static count as per your request
                      itemBuilder: (context, index) {
                        AttenteJoueursDemande joueurattente =
                            widget.equipeData.attenteJoueursDemande[index];

                        return _buildDemandeItem(
                            index,
                            joueurattente.joueur.id,
                            widget.equipeData.id,
                            widget.equipeData.nom,
                            joueurattente.joueur.username,
                            joueurattente.joueur.telephone,
                            joueurattente.post,
                            joueurattente.joueur.photo);
                        // This function will be defined to create each item
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------- attente---------------------------------------------
  Widget _buildProgressItem(int index, String joueurId, String equipeId,
      String? photo, String username) {
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
                  child: InkWell(
                    onTap: () {
                      EquipeCubit.get(context)
                          .checkUserByUsername(username: username)
                          .then((value) {
                        goProfile = true;
                      });
                    },
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
                        const Text('En attente'),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.hourglass_empty,
                      color: Colors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        EquipeCubit.get(context)
                            .capitaineAnnuleInvitationJoueur(
                          equipeId: equipeId,
                          joueurId: joueurId,
                        );
                      },
                      child: const Icon(Icons.cancel, color: Colors.red),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//-------------------------------------------------joueur --------------------------
  Widget _buildJoueurItem(int index, String joueurId, String equipeId,
      String username, String? photo, int? telephone) {
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
                  child: InkWell(
                    onTap: () {
                      EquipeCubit.get(context)
                          .checkUserByUsername(username: username)
                          .then((value) {
                        goProfile = true;
                      });
                    },
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
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Visibility(
                      visible: index != 0,
                      child: InkWell(
                        onTap: () {
                          int? phoneNumber = telephone;
                          if (phoneNumber != null) {
                            _makePhoneCall(phoneNumber.toString());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("No telephone number available."),
                              ),
                            );
                          }
                        },
                        child: Icon(Icons.call, color: greenConst),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Visibility(
                      visible: index != 0,
                      child: InkWell(
                        onTap: () {
                          EquipeCubit.get(context).quiterEquipe(
                            equipeId: equipeId,
                            joueurId: joueurId,
                          );
                        },
                        child: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//-------------------------------------------------------- add --------------------------------------
  Widget _buildAddItem(int index, String id, String equipename) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          _showAddDialog(context, id, equipename);
        },
        child: Container(
          height: 60,
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
          child: Center(
            child: Icon(Icons.add, color: greenConst, size: 30),
          ),
        ),
      ),
    );
  }

//------------------------------------ ajouter joueur dialog --------------------------------

  void _showAddDialog(
      BuildContext context, String equipeId, String equipename) {
    TextEditingController textEditingController = TextEditingController();
    String message = "";
    String? joueurId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Ajouter un nom d'utilisateur:"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Entrez le nom d'utilisateur",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (textEditingController.text.isNotEmpty) {
                            EquipeCubit.get(context).checkUserByUsername(
                                username: textEditingController.text);
                          }
                        },
                      ),
                    ),
                    onChanged: (value) {
                      if (message.isNotEmpty) {
                        setState(() =>
                            message = ""); // Clear message when typing starts
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<EquipeCubit, EquipeState>(
                    listener: (context, state) {
                      if (state is CheckUserByUsernameStateGood) {
                        print('ddddddddddddddddddddd');

                        joueurId =
                            state.dataJoueurModel.id; // Store the joueur ID
                        setState(() => message =
                            "Le joueur existe : ${state.dataJoueurModel.username}");
                      } else if (state is CheckUserByUsernameStateBad ||
                          state is ErrorState) {
                        setState(() => message = "Le joueur n'existe pas");
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadinCheckUserByUsernameState) {
                        return const CircularProgressIndicator();
                      }
                      return Text(message);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (joueurId != null) {
                            bool alreadyExists =
                                (widget.equipeData.attenteJoueurs.any(
                                      (joueur) => joueur.id == joueurId,
                                    ) ||
                                    widget.equipeData.joueurs.any(
                                      (joueur) => joueur.id == joueurId,
                                    ));
                            if (!alreadyExists) {
                              EquipeCubit.get(context).capitaineInviteJoueur(
                                  equipeId: equipeId,
                                  joueurId: joueurId!,
                                  equipename: equipename);
                              Navigator.of(context)
                                  .pop(); // Close the dialog after inviting
                            } else {
                              Navigator.of(context).pop();
                              showToast(
                                  msg:
                                      "Le joueur est déjà dans la liste d'attente.",
                                  state: ToastStates.error);
                            }
                          }
                        },
                        child: const Text("Inviter"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Annuler"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //------------------------ les demande ----------------------------------

  Widget _buildDemandeItem(
    int index,
    String joueurId,
    String equipeId,
    String equipename,
    String username,
    int? telephone,
    String? post,
    String? photo,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  child: InkWell(
                    onTap: () {
                      EquipeCubit.get(context)
                          .checkUserByUsername(username: username)
                          .then((value) {
                        goProfile = true;
                      });
                    },
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
                        Text(post!.isEmpty ? "Accepter" : post),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          int? phoneNumber = telephone;
                          if (phoneNumber != null) {
                            _makePhoneCall(phoneNumber.toString());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Aucun numéro de téléphone disponible."),
                              ),
                            );
                          }
                        },
                        child: Icon(Icons.call, color: greenConst)),
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          EquipeCubit.get(context).capitaineAceeptJoueur(
                            equipeId: equipeId,
                            joueurId: joueurId,
                            equipename: equipename,
                          );
                        },
                        child: Icon(Icons.check, color: greenConst)),
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          EquipeCubit.get(context).capitaineRefuseJoueur(
                            equipeId: equipeId,
                            joueurId: joueurId,
                          );
                        },
                        child: Icon(Icons.cancel, color: Colors.red)),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//------------------------ call--------------------------

  Future<void> _makePhoneCall(String phoneNumber) async {
    print(phoneNumber.runtimeType);
    print(phoneNumber);
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      await launchUrl(launchUri);
    } else {
      print('Permission refusée');
    }
  }

//--------------the end--------------
}
