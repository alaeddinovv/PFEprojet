import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/annonce/pulier/annonce_other_model.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';

class AnnouncementPage extends StatefulWidget {
  final String id;
  final bool isMy;

  const AnnouncementPage({super.key, required this.id, required this.isMy});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  late final AnnonceJoueurCubit cubit;
  late final AnnounceOter annonceDetails;

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
        title: const Text('Détails de l\'annonce'),
        backgroundColor: const Color(0XFF76A26C),
      ),
      body: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
        listener: (context, state) {
          if (state is GetAnnonceByIDStateGood) {
            annonceDetails = state.annonceModel;
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
                children: <Widget>[
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(color: const Color(0XFF76A26C), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Détails de l\'annonce',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildDetailRow('Type :', annonceDetails.type!),
                          buildDetailRow('Description :',
                              annonceDetails.description ?? ""),
                          buildDetailRow(
                              'Wilaya :', annonceDetails.wilaya ?? ""),
                          buildDetailRow(
                              'Commune :', annonceDetails.commune ?? ""),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(color: const Color(0XFF76A26C), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Détails du propriétaire',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (annonceDetails.user is Admin)
                            buildDetailRow(
                                'Nom :', annonceDetails.user?.nom ?? ""),
                          if (annonceDetails.user is Joueur)
                            buildDetailRow('Nom d\'utilisateur :',
                                annonceDetails.user?.username ?? ""),
                          buildDetailRow('Téléphone :',
                              annonceDetails.user?.telephone.toString() ?? ""),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(color: const Color(0XFF76A26C), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date de l\'annonce',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildDetailRow('Créé le :',
                              '${annonceDetails.createdAt?.year}-${annonceDetails.createdAt?.month.toString().padLeft(2, '0')}-${annonceDetails.createdAt?.day.toString().padLeft(2, '0')}'),
                          buildDetailRow('Dernière mise à jour :',
                              '${annonceDetails.updatedAt?.year}-${annonceDetails.updatedAt?.month.toString().padLeft(2, '0')}-${annonceDetails.updatedAt?.day.toString().padLeft(2, '0')}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ajouter la fonctionnalité d'appel ici
        },
        backgroundColor: const Color(0XFF76A26C),
        child: const Icon(Icons.call),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            TextSpan(text: ' '),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
