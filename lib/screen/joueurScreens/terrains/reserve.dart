import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

class Reserve extends StatelessWidget {
  Reserve(
      {super.key,
      required this.idTerrain,
      required this.hour,
      required this.date});
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
        title: const Text('Reserve'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const Text('User Id: ', style: TextStyle(fontSize: 20)),
                // const SizedBox(
                //   height: 8,
                // ),

                // defaultForm3(
                //   sufixIcon: BlocConsumer<TerrainCubit, TerrainState>(
                //     listener: (context, state) {
                //       if (state is CheckUserByIdStateGood) {
                //         showDialog(
                //           context: context,
                //           builder: (context) => DialogInfoJourur(
                //             state: state,
                //           ),
                //         );
                //       } else if (state is CheckUserByIdStateBad ||
                //           state is ErrorState) {
                //         showToast(
                //             msg: "User not found",
                //             state: ToastStates.error,
                //             gravity: ToastGravity.CENTER);
                //       }
                //     },
                //     builder: (context, state) {
                //       if (state is LoadinCheckUserByIdState) {
                //         return const CircularProgressIndicator();
                //       }
                //       return TextButton(
                //           onPressed: () {
                //             TerrainCubit.get(context)
                //                 .checkUserById(id: userIdController.text);
                //           },
                //           child: const Text('Check'));
                //     },
                //   ),
                //   prefixIcon: const Icon(Icons.person_outline),
                //   context: context,
                //   type: TextInputType.text,
                //   valid: (String value) {
                //     if (value.isEmpty) {
                //       return 'User Must Not Be Empty';
                //     }
                //   },
                //   labelText: 'User Id',
                //   controller: userIdController,
                // ),

                const SizedBox(
                  height: 16,
                ),
                const Text("Date de debut:", style: TextStyle(fontSize: 20)),
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
                    labelText:
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                    controller: dateController,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                const Text("Hour de debut:", style: TextStyle(fontSize: 20)),
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
                    labelText: hour,
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
                  labelText: 'Duree',
                  controller: dureeController,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Prix: 0.0', style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 16,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text('Payement: ', style: TextStyle(fontSize: 20)),
                //     StatefulBuilder(
                //       builder: (BuildContext context, StateSetter setState) {
                //         return Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Checkbox(
                //               value: isOuiChecked,
                //               onChanged: (bool? value) {
                //                 setState(() {
                //                   isOuiChecked = value!;
                //                   if (isOuiChecked) isNonChecked = false;
                //                 });
                //               },
                //             ),
                //             const Text('Oui'),
                //             const SizedBox(width: 10),
                //             Checkbox(
                //               value: isNonChecked,
                //               onChanged: (bool? value) {
                //                 setState(() {
                //                   isNonChecked = value!;
                //                   if (isNonChecked) isOuiChecked = false;
                //                 });
                //               },
                //             ),
                //             const Text('Non'),
                //           ],
                //         );
                //       },
                //     ),
                //   ],
                // ),

                const SizedBox(
                  height: 30,
                ),

                BlocConsumer<TerrainCubit, TerrainState>(
                  listener: (context, state) {
                    if (state is AddReservationStateGood) {
                      showToast(
                        msg: "Reservation Added Successfully",
                        state: ToastStates.success,
                      );
                      Navigator.pop(context);
                    } else if (state is AddReservationStateBad ||
                        state is ErrorState) {
                      showToast(
                        msg: "Error Adding Reservation",
                        state: ToastStates.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddReservationLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return defaultSubmit2(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic>? _model = {
                              "joueur_id":
                                  HomeJoueurCubit.get(context).joueurModel!.id,
                              "jour":
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                              "heure_debut_temps": hour,
                              "duree": dureeController.text,
                            };

                            TerrainCubit.get(context).addReservation(
                                idTerrain: idTerrain, model: _model);
                          }
                        },
                        text: 'Reserve',
                        background: Colors.blueAccent,
                      );
                    }
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

class DialogInfoJourur extends StatelessWidget {
  final CheckUserByIdStateGood state;
  const DialogInfoJourur({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black, // Set your desired text color here
            fontSize: 16.0, // Set your desired font size here
          ),
          children: [
            const TextSpan(
              text: 'Nom: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${state.dataJoueurModel.nom!}\n',
            ),
            const TextSpan(
              text: 'Prenom: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${state.dataJoueurModel.prenom!}\n',
            ),
            const TextSpan(
              text: 'Age: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${state.dataJoueurModel.age}',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: const Text('Done'))
      ],
    );
  }
}
