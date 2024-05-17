import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfeprojet/Model/annonce_search_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/location/terrain_location.dart';

class AnnonceSearchJoueurDetails extends StatefulWidget {
  final String id;

  const AnnonceSearchJoueurDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AnnonceSearchJoueurDetails> createState() =>
      _AnnonceSearchJoueurDetailsState();
}

class _AnnonceSearchJoueurDetailsState
    extends State<AnnonceSearchJoueurDetails> {
  late final AnnonceJoueurCubit cubit;
  late final AnnonceSearchJoueurModel annonceDetails;

  @override
  void initState() {
    cubit = AnnonceJoueurCubit.get(context);
    cubit.getAnnonceByID(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annonce Details'),
      ),
      body: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
        listener: (context, state) {
          if (state is GetAnnonceByIDStateGood) {
            annonceDetails = state.annonceSearchJoueurModel;
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
                  _buildDetailCard('Type', annonceDetails.type,
                      Icons.sports_soccer, Colors.orange),
                  _buildDetailCard('Date', annonceDetails.reservationId!.jour!,
                      Icons.calendar_today, Colors.green),
                  _buildDetailCard(
                      'Start Time',
                      annonceDetails.reservationId!.heureDebutTemps!,
                      Icons.access_time,
                      Colors.blue),
                  _buildDetailCardWithNavigation(
                    'Terrain Name and Address',
                    '${annonceDetails.terrainId.nom}, ${annonceDetails.terrainId.adresse}',
                    Icons.location_on,
                    Colors.red,
                    () {
                      navigatAndReturn(
                          context: context,
                          page: LocationTErrain(
                            terrainId: annonceDetails.terrainId.id.toString(),
                            location: LatLng(
                                annonceDetails.terrainId.coordonnee.latitude,
                                annonceDetails.terrainId.coordonnee.longitude),
                          ));
                    },
                  ),
                  _buildDetailCard(
                      'Number of Players',
                      annonceDetails.numeroJoueurs.toString(),
                      Icons.people,
                      Colors.purple),
                  _buildExpansionTile('Post Wanted', annonceDetails.postWant,
                      Icons.search, Colors.teal),
                  _buildDetailCard(
                      'Duration',
                      '${annonceDetails.reservationId!.duree} hours',
                      Icons.timer,
                      Colors.brown),
                  _buildTeamExpansionTile(
                      'Team 1',
                      annonceDetails.reservationId?.equipeId1 != null
                          ? annonceDetails.reservationId!.equipeId1!.joueurs
                          : [],
                      Colors.blue),
                  _buildTeamExpansionTile(
                      'Team 2',
                      annonceDetails.reservationId!.equipeId2 != null
                          ? annonceDetails.reservationId!.equipeId2!.joueurs
                          : [],
                      Colors.red),
                  _buildDetailCard('Description', annonceDetails.description,
                      Icons.description, Colors.grey),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showJoinRequestDialog(context),
                      child: const Text('Request to Join Team'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showJoinRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedPosition;
        return AlertDialog(
          title: const Text('Select Position'),
          content: DropdownButtonFormField<String>(
            items: annonceDetails.postWant.map((postWant) {
              return DropdownMenuItem<String>(
                value: postWant.post,
                child: Text(postWant.post),
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
  }

  Widget _buildDetailCardWithNavigation(String title, String subtitle,
      IconData icon, Color iconColor, VoidCallback onIconPressed) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildExpansionTile(
      String title, List<PostWant> items, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: items.map<Widget>((item) {
          return ListTile(
            leading: Icon(item.find ? Icons.done : Icons.hourglass_empty,
                color: item.find ? Colors.green : Colors.orange),
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
      String teamName, List<Joueurs> players, Color teamColor) {
    return Card(
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
