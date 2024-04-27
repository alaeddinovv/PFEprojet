import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    ReservationCubit cubit = ReservationCubit.get(context);
    return BlocConsumer<ReservationCubit, ReservationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetReservationLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: cubit.reservationList.length,
          itemBuilder: (context, index) {
            var reservation = cubit.reservationList[index];
            return Card(
              child: ListTile(
                title: Text(
                    '${reservation.jour!.month.toString().padLeft(2, '0')}/${reservation.jour!.day.toString().padLeft(2, '0')}  at ${reservation.heureDebutTemps}'),
                subtitle: Text(
                    'Duration: ${reservation.duree} hour(s), Status: ${reservation.etat}'),
                onTap: () {
                  // Navigate to details or handle other interactions
                },
              ),
            );
          },
        );
      },
    );
  }
}
