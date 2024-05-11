import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/reservation.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

class DetailMyReserve extends StatefulWidget {
  final DateTime jour;
  final String heure;
  final String terrainId;
  const DetailMyReserve(
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
            }
          },
          builder: (context, state) {
            if (state is GetMyReserveLoading) {
              return const Center(child: LinearProgressIndicator());
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
                    title: Text(formatDate(reservation!.jour)!),
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
                    subtitle: const Text('Duration'),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Team Details
                const Text(
                  'Your Team',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: Column(
                    children: List.generate(8, (index) {
                      return ListTile(
                        leading: const Icon(Icons.person, color: Colors.green),
                        title: Text(
                          'Player ${index + 1}',
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 20.0),
                const Text(
                  "Opponent's Team",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                // Display opponent's team list
                Card(
                  child: Column(
                    children: List.generate(8, (index) {
                      return ListTile(
                        leading: const Icon(Icons.person, color: Colors.red),
                        title: Text('Opponent Player ${index + 1}'),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 20.0),
                // Confirmation Button
                ElevatedButton(
                  onPressed: () {
                    // Handle reservation confirmation
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // foreground
                  ),
                  child: const Text('Confirm Reservation'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
