import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/searchJoueur.dart';
import 'package:pfeprojet/generated/l10n.dart';

class Reserve extends StatelessWidget {
  Reserve({
    super.key,
    required this.idTerrain,
    required this.hour,
    required this.date,
  });

  final String idTerrain;
  final String hour;
  final DateTime date;
  final formKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final dureeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reserve),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(S.of(context).username, style: TextStyle(fontSize: 20)),
                SearchTest(
                  userIdController: userIdController,
                ),
                Text(S.of(context).start_date, style: TextStyle(fontSize: 20)),
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
                    labelText:
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                    controller: dateController,
                  ),
                ),
                const SizedBox(height: 16),
                Text(S.of(context).start_hour, style: TextStyle(fontSize: 20)),
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
                    labelText: hour,
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
                  valid: (String value) {
                    if (value.isEmpty) {
                      return S.of(context).duration_must_not_be_empty;
                    }
                  },
                  labelText: S.of(context).duration,
                  controller: dureeController,
                ),
                const SizedBox(height: 46),
                BlocConsumer<TerrainCubit, TerrainState>(
                  listener: (context, state) {
                    if (state is AddReservationStateGood) {
                      showToast(
                        msg: S.of(context).reservation_added_successfully,
                        state: ToastStates.success,
                      );
                      Navigator.pop(context);
                    } else if (state is AddReservationStateBad ||
                        state is ErrorState) {
                      showToast(
                        msg: S.of(context).error_adding_reservation,
                        state: ToastStates.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return defaultSubmit2(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic>? _model = {
                            "joueur_id": userIdController.text,
                            "jour":
                                "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                            "heure_debut_temps": hour,
                            "duree": dureeController.text,
                          };

                          TerrainCubit.get(context).addReservation(
                            idTerrain: idTerrain,
                            model: _model,
                          );
                        }
                      },
                      text: S.of(context).reserve,
                      background: Colors.blueAccent,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
