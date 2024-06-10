import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/annonce/pulier/annonce_other_model.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/cubit/annonce_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';

class AnnouncementPage extends StatefulWidget {
  final String id;

  const AnnouncementPage({super.key, required this.id});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  late final AnnonceCubit cubit;
  late final AnnounceOter annonceDetails;

  @override
  void initState() {
    cubit = AnnonceCubit.get(context);
    cubit.getAnnonceByID(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).announcement_details),
      ),
      body: BlocConsumer<AnnonceCubit, AnnonceState>(
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
                            S.of(context).announcement_details,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildDetailRow(
                              S.of(context).type, annonceDetails.type!),
                          buildDetailRow(S.of(context).description,
                              annonceDetails.description ?? ""),
                          buildDetailRow(S.of(context).wilaya,
                              annonceDetails.wilaya ?? ""),
                          buildDetailRow(S.of(context).commune,
                              annonceDetails.commune ?? ""),
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
                            S.of(context).owner_details,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (annonceDetails.user is Admin)
                            buildDetailRow(S.of(context).name,
                                annonceDetails.user?.nom ?? ""),
                          if (annonceDetails.user is Joueur)
                            buildDetailRow(S.of(context).username,
                                annonceDetails.user?.username ?? ""),
                          buildDetailRow(S.of(context).phone,
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
                            S.of(context).announcement_timestamp,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFF76A26C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildDetailRow(S.of(context).created_at,
                              '${annonceDetails.createdAt?.year}-${annonceDetails.createdAt?.month.toString().padLeft(2, '0')}-${annonceDetails.createdAt?.day.toString().padLeft(2, '0')}'),
                          buildDetailRow(S.of(context).last_update,
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
          // Add call functionality here
        },
        backgroundColor: const Color(0XFF76A26C),
        child: const Icon(Icons.call),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
