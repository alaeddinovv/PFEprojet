import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';

class ReservationPlayerInfo extends StatelessWidget {
  ReservationPlayerInfo({super.key});

  final formKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final dureeController = TextEditingController();
  final username = TextEditingController();
  late final String groupID;

  @override
  Widget build(BuildContext context) {
    TerrainCubit cubit = TerrainCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reserve),
      ),
      body: BlocConsumer<TerrainCubit, TerrainState>(
        listener: (context, state) {
          if (state is DeleteReservationStateGood) {
            showToast(
              msg: S.of(context).delete_reservation_successfully,
              state: ToastStates.success,
            );
            Navigator.pop(context);
          }
          if (state is GetReservationJoueurInfoStateGood) {
            TerrainCubit.get(context)
                .checkUserById(id: state.reservations.first.joueurId!);

            userIdController.text =
                state.reservations.first.joueurId.toString();
            dateController.text =
                '${state.reservations.first.jour!.year}/${state.reservations.first.jour!.month.toString().padLeft(2, '0')}/${state.reservations.first.jour!.day.toString().padLeft(2, '0')}';
            hourController.text =
                state.reservations.first.heureDebutTemps.toString();
            dureeController.text = state.reservations.first.duree.toString();
            groupID = state.reservations.first.reservationGroupId!;
          }
          if (state is CheckUserByIdStateGood) {
            username.text = state.dataJoueurModel.username!;
          }
        },
        builder: (context, state) {
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
                      Text(S.of(context).username,
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      defaultForm3(
                        prefixIcon: const Icon(Icons.person_outline),
                        context: context,
                        type: TextInputType.text,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return S.of(context).user_must_not_be_empty;
                          }
                        },
                        enabled: false,
                        readOnly: true,
                        controller: username,
                      ),
                      const SizedBox(height: 16),
                      Text(S.of(context).start_date,
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 250,
                        child: defaultForm3(
                          enabled: false,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          context: context,
                          readOnly: true,
                          type: TextInputType.datetime,
                          valid: (String value) {},
                          controller: dateController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(S.of(context).start_hour,
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 250,
                        child: defaultForm3(
                          enabled: false,
                          prefixIcon: const Icon(Icons.timer_outlined),
                          context: context,
                          readOnly: true,
                          type: TextInputType.number,
                          valid: (String value) {},
                          controller: hourController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(S.of(context).duration_in_weeks,
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 8),
                      defaultForm3(
                        prefixIcon: const Icon(Icons.timer_outlined),
                        context: context,
                        type: TextInputType.number,
                        valid: (String value) {},
                        controller: dureeController,
                        enabled: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 40),
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
                            text: S.of(context).remove_reservation,
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
        },
      ),
    );
  }
}
