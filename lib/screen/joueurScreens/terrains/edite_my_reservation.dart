import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/reservation_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/search_my_equipe.dart';

class DetailMyReserve extends StatefulWidget {
  final DateTime jour;
  final String heure;
  final String terrainId;
  final TextEditingController equipeIdController = TextEditingController();
  DetailMyReserve(
      {super.key,
      required this.jour,
      required this.heure,
      required this.terrainId});

  @override
  State<DetailMyReserve> createState() => _DetailMyReserveState();
}

class _DetailMyReserveState extends State<DetailMyReserve> {
  late final TerrainCubit cubit;

  final TextEditingController equipeIdController = TextEditingController();

  ReservationModel? reservation;

  @override
  void initState() {
    cubit = TerrainCubit.get(context);
    cubit.getMyreserve(
        date: widget.jour,
        heure_debut_temps: widget.heure,
        terrainId: widget.terrainId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Reservation'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TerrainCubit, TerrainState>(
          listener: (context, state) {
            if (state is GetMyReserveStateGood) {
              reservation = state.reservations;
              print('reservations: $reservation');
            }
            if (state is ConfirmConnectEquipeStateGood) {
              showToast(msg: 'Connected Confirm', state: ToastStates.success);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is GetMyReserveLoading) {
              return const Center(child: LinearProgressIndicator());
            }
            if (state is GetMyReserveStateBad) {
              return const Center(child: Text('Error'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                // Reservation Details
                const Text(
                  'Reservation Details',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                // Date Selection
                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.calendar_today, color: Colors.green),
                    title: Text(formatDate(reservation!.jour!)!,
                        style: const TextStyle(fontSize: 20.0)),
                    subtitle: const Text('Date'),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Time Selection
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.green),
                    title: Text(reservation!.heureDebutTemps!),
                    subtitle: const Text('Time'),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Duration Selection
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.timer, color: Colors.green),
                    title: Text(reservation!.duree.toString()),
                    subtitle: const Text('semaines'),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Team Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Team : (${reservation!.equipe1 != null ? reservation!.equipe1!.nom : 'No team'})',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('choose :'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title:
                                            const Text('for all reservation'),
                                        onTap: () {
                                          Navigator.pop(context);

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SearchTest(
                                                      equipeIdController:
                                                          equipeIdController,
                                                      onEquipeSelected:
                                                          (equipe) {
                                                        setState(() {
                                                          reservation!.equipe1 =
                                                              equipe;
                                                          print(
                                                              'equipe1: ${reservation!.equipe1!.id}');
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                      ListTile(
                                        title:
                                            const Text('for this reservation'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                  ],
                ),
                reservation!.equipe1 != null
                    ? Card(
                        child: Column(
                          children: List.generate(
                              reservation!.equipe1!.numeroJoueurs!, (index) {
                            return ListTile(
                              leading:
                                  const Icon(Icons.person, color: Colors.green),
                              title:
                                  index < reservation!.equipe1!.joueurs!.length
                                      ? Text(reservation!
                                          .equipe1!.joueurs![index].username!)
                                      : const Text(
                                          'Not assigned yet',
                                          style: TextStyle(color: Colors.red),
                                        ),
                            );
                          }),
                        ),
                      )
                    : const Center(child: Text('you dont have a team yet')),
                const SizedBox(height: 20.0),
                Text(
                  "Opponent's Team : (${reservation!.equipe2 != null ? reservation!.equipe2!.nom : 'No team'})",
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                // Display opponent's team list
                reservation!.equipe2 != null
                    ? Card(
                        child: Column(
                          children: List.generate(8, (index) {
                            return ListTile(
                              leading:
                                  const Icon(Icons.person, color: Colors.red),
                              title: Text('Opponent Player ${index + 1}'),
                            );
                          }),
                        ),
                      )
                    : const Center(child: Text('No opponent team yet')),

                const SizedBox(height: 20.0),
                state is ConfirmConnectEquipeLoading
                    ? const Center(child: CircularProgressIndicator())
                    : defaultSubmit2(
                        text: 'Confirm connection',
                        onPressed: () {
                          cubit.confirmConnectEquipe(
                            reservationGroupId:
                                reservation!.reservationGroupId!,
                            equipe1: reservation!.equipe1!.id,
                          );
                        },
                        background: Colors.green),
              ],
            );
          },
        ),
      ),
    );
  }
}
