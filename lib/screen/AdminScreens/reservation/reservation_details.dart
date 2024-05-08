import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/reservation_pagination_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final ReservationPaginationModelData reservation;

  const ReservationDetailsScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
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
                          'Duration: ${reservation.duree} week(s)',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          'Status: ${reservation.etat}',
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
                          'Hour: ${reservation.heureDebutTemps}',
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
                          'Username: ${reservation.joueurId!.username}',
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
                          'Telephone: ${reservation.joueurId!.telephone}',
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
                          msg: 'added successfully',
                          state: ToastStates.success);
                      Navigator.pop(context);
                    } else if (state is AddReservationStateBad) {
                      showToast(msg: 'error', state: ToastStates.error);
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
                          backgroundColor:
                              Colors.green, // foreground (text) color
                        ),
                        child: const Text('Accept'),
                        onPressed: () {
                          Map<String, dynamic>? _model = {
                            "joueur_id": reservation.joueurId!.id,
                            "jour":
                                "${reservation.jour!.year}-${reservation.jour!.month.toString().padLeft(2, '0')}-${reservation.jour!.day.toString().padLeft(2, '0')}",
                            "heure_debut_temps": reservation.heureDebutTemps,
                            "duree": reservation.duree,
                          };
                          ReservationCubit.get(context).addReservation(
                              model: _model, idReservation: reservation.id);
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
                          msg: 'Deleted successfully',
                          state: ToastStates.success);
                      Navigator.pop(context);
                    } else if (state is DeleteReservationStateBad) {
                      showToast(msg: 'error', state: ToastStates.error);
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
                          backgroundColor:
                              Colors.red, // foreground (text) color
                        ),
                        child: const Text('Refuse'),
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
