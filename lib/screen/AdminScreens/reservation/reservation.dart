import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange &&
            ReservationCubit.get(context).cursorId != "") {
          ReservationCubit.get(context).fetchReservations(
              cursor: ReservationCubit.get(context).cursorId);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    ReservationCubit cubit = ReservationCubit.get(context);
    return BlocConsumer<ReservationCubit, ReservationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetReservationStateBad) {
          return const Text(
              'Failed to fetch data'); // Display a message if fetching data failed
        }
        if (state is GetReservationLoadingState && cubit.cursorId == '') {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
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
              ),
            ),
            if (state is GetReservationLoadingState && cubit.cursorId != '')
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
