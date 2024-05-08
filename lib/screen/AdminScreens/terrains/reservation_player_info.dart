import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class ReservationPlayerInfo extends StatelessWidget {
  ReservationPlayerInfo({super.key});

  final formKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final dureeController = TextEditingController();
  late final String groupID;

  @override
  Widget build(BuildContext context) {
    TerrainCubit cubit = TerrainCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve'),
      ),
      body:
          BlocConsumer<TerrainCubit, TerrainState>(listener: (context, state) {
        if (state is DeleteReservationStateGood) {
          showToast(
              msg: 'Delete Reservation Successfully',
              state: ToastStates.success);
          Navigator.pop(context);
        }
        if (state is GetReservationJoueurInfoStateGood) {
          userIdController.text = state.reservations.first.joueurId.toString();
          dateController.text =
              '${state.reservations.first.jour!.year}/${state.reservations.first.jour!.month.toString().padLeft(2, '0')}/${state.reservations.first.jour!.day.toString().padLeft(2, '0')}';
          hourController.text =
              state.reservations.first.heureDebutTemps.toString();
          dureeController.text = state.reservations.first.duree.toString();
          groupID = state.reservations.first.reservationGroupId!;
        }
      }, builder: (context, state) {
        if (state is GetReservationJoueurInfoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('User Id: ', style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    defaultForm3(
                      prefixIcon: const Icon(Icons.person_outline),
                      context: context,
                      type: TextInputType.text,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'User Must Not Be Empty';
                        }
                      },
                      enabled: false,
                      readOnly: true,
                      // labelText: joueurId,
                      controller: userIdController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Date de debut:",
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 250,
                      child: defaultForm3(
                        enabled: false,
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        context: context,
                        readOnly: true,
                        type: TextInputType.datetime,
                        valid: (String value) {},
                        // labelText:
                        //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                        controller: dateController,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Hour de debut:",
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 250,
                      child: defaultForm3(
                        enabled: false,
                        prefixIcon: const Icon(Icons.timer_outlined),
                        context: context,
                        readOnly: true,
                        type: TextInputType.number,
                        valid: (String value) {},
                        // labelText: hour,
                        controller: hourController,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Duree (en Semaine): ',
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 8),
                    defaultForm3(
                      prefixIcon: const Icon(Icons.timer_outlined),
                      context: context,
                      type: TextInputType.number,
                      valid: (String value) {},
                      // labelText: duree,
                      controller: dureeController,
                      enabled: false,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocConsumer<TerrainCubit, TerrainState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is DeleteReservationLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return defaultSubmit2(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.deleteReservationGroup(groupID: groupID);
                            }
                          },
                          text: 'Remove Reservation',
                          background: Colors.blueAccent,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
