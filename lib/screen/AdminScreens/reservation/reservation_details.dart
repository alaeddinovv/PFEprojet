import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/reservation_pagination_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final ReservationPaginationModelData reservation;

  const ReservationDetailsScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reservation_details),
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
                          '${S.of(context).duration}: ${reservation.duree} ${S.of(context).weeks}',
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
                          '${S.of(context).status}: ${reservation.etat}',
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
                          '${S.of(context).time}: ${reservation.heureDebutTemps}',
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
                          '${S.of(context).field}: ${reservation.terrainId!.nom}',
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
                          '${S.of(context).username}: ${reservation.joueurId!.username}',
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
                          '${S.of(context).phone}: ${reservation.joueurId!.telephone}',
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
                          msg: S.of(context).added_successfully,
                          state: ToastStates.success);
                      sendNotificationToJoueur(
                          title: S.of(context).reservation_accepted,
                          body:
                              '${S.of(context).stadium_name} ${reservation.terrainId?.nom} ${S.of(context).reservation_accepted_for} ${formatDate(reservation.jour)} ${S.of(context).at} ${reservation.heureDebutTemps}',
                          joueurId: reservation.joueurId!.id!);
                      Navigator.pop(context);
                    } else if (state is AddReservationStateBad) {
                      showToast(
                          msg: S.of(context).error, state: ToastStates.error);
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
                        child: Text(S.of(context).accept),
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
                          msg: S.of(context).deleted_successfully,
                          state: ToastStates.success);
                      sendNotificationToJoueur(
                          title: S.of(context).reservation_declined,
                          body:
                              '${S.of(context).stadium_name} ${reservation.terrainId?.nom} ${S.of(context).reservation_declined_for} ${formatDate(reservation.jour)} ${S.of(context).at} ${reservation.heureDebutTemps}',
                          joueurId: reservation.joueurId!.id!);
                      Navigator.pop(context);
                    } else if (state is DeleteReservationStateBad) {
                      showToast(
                          msg: S.of(context).error, state: ToastStates.error);
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
                        child: Text(S.of(context).decline),
                        onPressed: () {
                          print(reservation.id);
                          ReservationCubit.get(context).removeReservation(
                            idReservation: reservation.id!,
                          );
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
