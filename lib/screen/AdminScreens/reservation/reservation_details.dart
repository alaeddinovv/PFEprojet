import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/reservation_pagination_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final ReservationPaginationModelData reservation;

  const ReservationDetailsScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la réservation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          'Durée: ${reservation.duree} semaine(s)',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: greenConst),
                        const SizedBox(width: 8),
                        Text(
                          'État: ${reservation.etat}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Heure: ${reservation.heureDebutTemps}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.sports_soccer, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          'Terrain: ${reservation.terrainId!.nom}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.account_circle, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Nom d\'utilisateur: ${reservation.joueurId!.username}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(
                          'Téléphone: ${reservation.joueurId!.telephone}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                BlocConsumer<ReservationCubit, ReservationState>(
                  listener: (context, state) {
                    if (state is AddReservationStateGood) {
                      showToast(
                          msg: 'Ajouté avec succès',
                          state: ToastStates.success);
                      sendNotificationToJoueur(
                          title: 'Acceptez votre réservation',
                          body:
                              'Le nom du stade ${reservation.terrainId?.nom} a accepté votre réservation pour le ${formatDate(reservation.jour)} à ${reservation.heureDebutTemps}',
                          joueurId: reservation.joueurId!.id!);
                      Navigator.pop(context);
                    } else if (state is AddReservationStateBad) {
                      showToast(msg: 'Erreur', state: ToastStates.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddReservationLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: greenConst,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text('Accepter'),
                        onPressed: () {
                          Map<String, dynamic>? _model = {
                            "joueur_id": reservation.joueurId!.id,
                            "jour":
                                "${reservation.jour!.year}-${reservation.jour!.month.toString().padLeft(2, '0')}-${reservation.jour!.day.toString().padLeft(2, '0')}",
                            "heure_debut_temps": reservation.heureDebutTemps,
                            "duree": reservation.duree,
                          };
                          ReservationCubit.get(context).addReservation(
                            model: _model,
                            idReservation: reservation.id,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                BlocConsumer<ReservationCubit, ReservationState>(
                  listener: (context, state) {
                    if (state is DeleteReservationStateGood) {
                      showToast(
                          msg: 'Supprimé avec succès',
                          state: ToastStates.success);
                      sendNotificationToJoueur(
                          title: 'refuser votre réservation',
                          body:
                              'Le nom du stade ${reservation.terrainId?.nom} a refuser votre réservation pour le ${formatDate(reservation.jour)} à ${reservation.heureDebutTemps}',
                          joueurId: reservation.joueurId!.id!);
                      Navigator.pop(context);
                    } else if (state is DeleteReservationStateBad) {
                      showToast(msg: 'Erreur', state: ToastStates.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteReservationLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text('Refuser'),
                        onPressed: () {
                          print(reservation.id);
                          ReservationCubit.get(context).removeReservation(
                            idReservation: reservation.id!,
                          );
                          // Handle refuse action
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
