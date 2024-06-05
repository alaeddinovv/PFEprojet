// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfeprojet/Api/color.dart';

import 'package:pfeprojet/Model/annonce/pulier/annonce_search_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/location/terrain_location.dart';

class AnnonceSearchJoueurDetails extends StatefulWidget {
  final String id;
  final bool isMyAnnonce;

  const AnnonceSearchJoueurDetails({
    Key? key,
    required this.id,
    required this.isMyAnnonce,
  }) : super(key: key);

  @override
  State<AnnonceSearchJoueurDetails> createState() =>
      _AnnonceSearchJoueurDetailsState();
}

class _AnnonceSearchJoueurDetailsState
    extends State<AnnonceSearchJoueurDetails> {
  late final AnnonceJoueurCubit cubit;

  AnnonceSearchJoueurModel? annonceDetails;
  bool isEditingPost = false;
  bool isEditingDescription = false;

  @override
  void initState() {
    cubit = AnnonceJoueurCubit.get(context);
    cubit.getAnnonceByID(id: widget.id);
    super.initState();
  }

  void _toggleEditing({required String title}) {
    if (title == 'Description') {
      setState(() {
        isEditingDescription = !isEditingDescription;
      });
    } else if (title == 'Post Wanted') {
      setState(() {
        isEditingPost = !isEditingPost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annonce Details'),
      ),
      body: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
        listener: (context, state) async {
          if (state is GetAnnonceByIDStateGood) {
            annonceDetails = state.annonceModel;
          }
          if (state is UpdateAnnonceJoueurStateGood) {
            showToast(
                msg: 'Update Annonce Success', state: ToastStates.success);
            Navigator.pop(context);
          }
          if (state is DemandeRejoindreEquipeStateGood) {
            Navigator.pop(context);
            showToast(msg: 'Request to join sent', state: ToastStates.success);
            await sendNotificationToJoueur(
                title: 'request to join equipe',
                body:
                    '${state.userName} send request to join ${state.equipeName}\n post: ${state.post} ',
                joueurId: state.joueurId);
          }
        },
        builder: (context, state) {
          if (state is GetAnnonceByIDLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailCard('Type', annonceDetails?.type ?? '',
                      Icons.sports_soccer, greenConst),
                  _buildDetailCard(
                      'Date',
                      formatDate(annonceDetails?.reservationId.jour) ?? '',
                      Icons.calendar_today,
                      greenConst),
                  _buildDetailCard(
                      'Start Time',
                      annonceDetails?.reservationId.heureDebutTemps ?? '',
                      Icons.access_time,
                      greenConst),
                  _buildDetailCardWithNavigation(
                    'Terrain Name and Address',
                    '${annonceDetails?.terrainId.nom}, ${annonceDetails?.terrainId.adresse}',
                    Icons.location_on,
                    greenConst,
                    () {
                      if (annonceDetails?.terrainId != null) {
                        navigatAndReturn(
                          context: context,
                          page: LocationTErrain(
                            terrainId: annonceDetails!.terrainId.id.toString(),
                            location: LatLng(
                                annonceDetails!.terrainId.coordonnee.latitude,
                                annonceDetails!.terrainId.coordonnee.longitude),
                          ),
                        );
                      } else {
                        showToast(
                            msg: 'No Terrain find', state: ToastStates.warning);
                      }
                    },
                  ),
                  _buildDetailCard(
                      'Number of Players',
                      annonceDetails?.postWant.length.toString() ?? '',
                      Icons.people,
                      greenConst),
                  _buildExpansionTile('Post Wanted',
                      annonceDetails?.postWant ?? [], Icons.search, greenConst),
                  _buildDetailCard(
                      'Duration',
                      '${annonceDetails?.reservationId.duree} hours',
                      Icons.timer,
                      greenConst),
                  _buildTeamExpansionTile(
                      'Team 1: ${annonceDetails?.reservationId.equipeId1?.nom}',
                      annonceDetails?.reservationId.equipeId1 != null
                          ? annonceDetails?.reservationId.equipeId1!.joueurs ??
                              []
                          : [],
                      greenConst),
                  _buildTeamExpansionTile(
                      'Team 2 : ${annonceDetails?.reservationId.equipeId2?.nom}',
                      annonceDetails?.reservationId.equipeId2 != null
                          ? annonceDetails?.reservationId.equipeId2!.joueurs ??
                              []
                          : [],
                      Colors.red),
                  _buildDetailCardDescription(
                      'Description',
                      annonceDetails?.description ?? '',
                      Icons.description,
                      greenConst),
                  const SizedBox(height: 20),
                  Center(
                      child: widget.isMyAnnonce
                          ? state is UpdateAnnonceJoueurLoadingState
                              ? const CircularProgressIndicator()
                              : defaultSubmit2(
                                  text: 'Update Annonce',
                                  onPressed: () {
                                    List<Map<String, dynamic>> postWantList =
                                        annonceDetails!.postWant
                                            .map(
                                                (postWant) => postWant.toJson())
                                            .toList();
                                    Map<String, dynamic> model = {
                                      'description':
                                          annonceDetails?.description,
                                      'post_want': postWantList,
                                      'numero_joueurs':
                                          annonceDetails?.postWant.length,
                                      'wilaya': annonceDetails?.wilaya,
                                      'commune': annonceDetails?.commune,
                                    };
                                    AnnonceJoueurCubit.get(context)
                                        .updateAnnonceJoueur(
                                            model: model,
                                            id: annonceDetails!.id);
                                  })
                          : defaultSubmit2(
                              text: 'request to join Match',
                              onPressed: () {
                                if (annonceDetails != null ||
                                    annonceDetails?.terrainId != null ||
                                    annonceDetails?.reservationId.equipeId1 !=
                                        null) {
                                  _showJoinRequestDialog(context);
                                }
                              })),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showJoinRequestDialog(BuildContext context) {
    List<PostWant> availablePositions =
        annonceDetails!.postWant.where((postWant) => !postWant.find).toList();

    // Create a set to store unique positions
    Set<String> uniquePositions =
        availablePositions.map((postWant) => postWant.post).toSet();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedPosition;
        return AlertDialog(
          title: const Text('Select Position'),
          content: DropdownButtonFormField<String>(
            items: uniquePositions.map((position) {
              return DropdownMenuItem<String>(
                value: position,
                child: Text(position),
              );
            }).toList(),
            onChanged: (value) {
              selectedPosition = value;
            },
            decoration: const InputDecoration(
              labelText: 'Position',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedPosition != null) {
                  _sendJoinRequest(selectedPosition!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }

  void _sendJoinRequest(String position) {
    // Implement the logic to send the join request
    print('Request to join as $position sent.');
    AnnonceJoueurCubit.get(context).demanderRejoindreEquipe(
        userName: HomeJoueurCubit.get(context).joueurModel!.username!,
        equipeId: annonceDetails!.reservationId.equipeId1!.id,
        post: position,
        nameEquipe: annonceDetails!.reservationId.equipeId1!.nom,
        joueurId: annonceDetails!.reservationId.equipeId1!.capitaine_id!);
  }

  Widget _buildDetailCardWithNavigation(String title, String subtitle,
      IconData icon, Color iconColor, VoidCallback onIconPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: iconColor, width: 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: onIconPressed,
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildDetailCard(
      String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: iconColor, width: 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildDetailCardDescription(
      String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: iconColor, width: 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // const SizedBox(width: 8.0),
            if (widget.isMyAnnonce)
              IconButton(
                onPressed: () {
                  _toggleEditing(title: title);
                },
                icon: Icon(
                  isEditingDescription ? Icons.done : Icons.edit,
                  size: 20,
                ),
              ),
          ],
        ),
        subtitle: isEditingDescription && title == 'Description'
            ? TextFormField(
                maxLines: 5,
                initialValue: subtitle,
                onChanged: (value) {
                  setState(() {
                    annonceDetails?.description = value;
                  });
                },
              )
            : Text(subtitle),
      ),
    );
  }

  Widget _buildExpansionTile(
      String title, List<PostWant> items, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: iconColor, width: 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: iconColor),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // const SizedBox(width: 8.0),
            if (widget.isMyAnnonce)
              IconButton(
                onPressed: () {
                  _toggleEditing(title: 'Post Wanted');
                },
                icon: Icon(
                  isEditingPost ? Icons.done : Icons.edit,
                  size: 20,
                ),
              ),
          ],
        ),
        children: isEditingPost
            ? [
                ...items.map<Widget>((item) {
                  return ListTile(
                    leading: Checkbox(
                      value: item.find,
                      onChanged: (value) {
                        setState(() {
                          item.find = value!;
                        });
                      },
                    ),
                    title: DropdownButtonFormField<String>(
                      value: item.post,
                      items: ['attaquant', 'defenseur', 'gardia', 'milieu']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          item.post = value!;
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          items.remove(item);
                        });
                      },
                    ),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items.add(PostWant(
                        post: 'attaquant',
                        find: false,
                      ));
                    });
                  },
                  child: const Text('Add Post Want'),
                ),
              ]
            : items.map<Widget>((item) {
                return ListTile(
                  leading: Icon(
                    item.find ? Icons.done : Icons.hourglass_empty,
                    color: item.find ? greenConst : Colors.orange,
                  ),
                  title: Text(
                    item.post,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                );
              }).toList(),
      ),
    );
  }

  Widget _buildTeamExpansionTile(
      String teamName, List<Joueur> players, Color teamColor) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: Icon(Icons.group, color: teamColor),
        title: Text(
          teamName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: players.map<Widget>((player) {
          return ListTile(
            title: Text('${player.nom} ${player.prenom}'),
            subtitle: Text('Phone: ${player.telephone.toString()}'),
          );
        }).toList(),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final List<dynamic> players;

  const PlayerList({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                players[index]['nom'][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              '${players[index]['nom']} ${players[index]['prenom']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Phone: ${players[index]['telephone']}',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14.0),
          ),
        );
      },
    );
  }
}
