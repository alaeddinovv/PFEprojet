import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/reservation/reservation_details.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart'
    as TerrainCubit;

// ignore: must_be_immutable
class Reservation extends StatefulWidget {
  Reservation({super.key});
  String? dropdownValue;
  String? nameOfTerrain;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
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
              cursor: ReservationCubit.get(context).cursorId,
              date: formatDate(widget.selectedDate),
              heureDebutTemps: formatTimeOfDay(widget.selectedTime),
              terrainId: widget.dropdownValue);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    ReservationCubit cubit = ReservationCubit.get(context);

    return BlocListener<ReservationCubit, ReservationState>(
      listener: (context, state) {
        if (state is DeleteReservationStateGood) {
          setState(() {
            cubit.fetchReservations(
                date: formatDate(widget.selectedDate),
                heureDebutTemps: formatTimeOfDay(widget.selectedTime),
                terrainId: widget.dropdownValue);
          });
        }
        // TODO: implement listener
      },
      child: Column(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            label: const Text('Select Day'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // round corner
              ),
            ),
            onPressed: () => selectDate(),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.access_time, color: Colors.white),
            label: const Text('Select Hour'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // round corner
              ),
            ),
            onPressed: () => selectTime(),
          ),
          DropdownButton<String>(
            value: widget.dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.dropdownValue = newValue!;
                cubit.fetchReservations(
                    date: formatDate(widget.selectedDate),
                    heureDebutTemps: formatTimeOfDay(widget.selectedTime),
                    terrainId: widget.dropdownValue);
              });
            },
            items: TerrainCubit.TerrainCubit.get(context)
                .terrains
                .map<DropdownMenuItem<String>>((TerrainModel terrain) {
              return DropdownMenuItem<String>(
                value: terrain.id,
                child: Text(terrain.nom!),
                onTap: () {
                  setState(() {
                    widget.nameOfTerrain = terrain.nom;
                  });
                },
              );
            }).toList(),
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              if (widget.selectedDate != null)
                Chip(
                  label: Text(
                      'jour: ${widget.selectedDate?.day.toString().padLeft(2, "0")}/${widget.selectedDate?.month.toString().padLeft(2, "0")}/${widget.selectedDate?.year}'),
                  deleteIcon: const Icon(
                    Icons.cancel,
                  ),
                  onDeleted: () {
                    setState(() {
                      widget.selectedDate = null;
                      cubit.fetchReservations(
                          heureDebutTemps:
                              formatTimeOfDay(widget.selectedTime));
                    });
                  },
                  deleteIconColor: Colors.redAccent,
                  deleteButtonTooltipMessage: 'Remove this day',
                ),
              if (widget.selectedTime != null)
                Chip(
                  label: Text(
                      'Hour: ${widget.selectedTime!.hour.toString().padLeft(2, '0')}:${widget.selectedTime!.minute.toString().padLeft(2, '0')}'),
                  deleteIcon: const Icon(
                    Icons.cancel,
                  ),
                  onDeleted: () {
                    setState(() {
                      widget.selectedTime = null;
                      cubit.fetchReservations(
                          date: formatDate(widget.selectedDate));
                    });
                  },
                  deleteIconColor: Colors.redAccent,
                  deleteButtonTooltipMessage: 'Remove this hour',
                ),
            ],
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              if (widget.nameOfTerrain != null)
                Chip(
                  label: Text('Stadium: ${widget.nameOfTerrain}'),
                  deleteIcon: const Icon(
                    Icons.cancel,
                  ),
                  onDeleted: () {
                    setState(() {
                      widget.dropdownValue = null;
                      widget.nameOfTerrain = null;
                      cubit.fetchReservations(
                          date: formatDate(widget.selectedDate),
                          heureDebutTemps: formatTimeOfDay(widget.selectedTime),
                          terrainId: widget.dropdownValue);
                    });
                  },
                  deleteIconColor: Colors.redAccent,
                  deleteButtonTooltipMessage: 'Remove this stadium',
                ),
            ],
          ),
          BlocBuilder<ReservationCubit, ReservationState>(
            builder: (context, state) {
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: cubit.reservationList.length,
                        itemBuilder: (context, index) {
                          var reservation = cubit.reservationList[index];
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                      '${reservation.jour!.month.toString().padLeft(2, '0')}/${reservation.jour!.day.toString().padLeft(2, '0')}  at ${reservation.heureDebutTemps}'),
                                  const Spacer(),
                                  Text(
                                    reservation.terrainId!.nom.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800]),
                                  )
                                ],
                              ),
                              subtitle: Text(
                                  'Duration: ${reservation.duree} semain(s), Status: ${reservation.etat}\n username: ${reservation.joueurId!.username}'),
                              onTap: () {
                                // Navigate to details or handle other interactions
                                navigatAndReturn(
                                    context: context,
                                    page: ReservationDetailsScreen(
                                        reservation: reservation));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    if (state is GetReservationLoadingState &&
                        cubit.cursorId != '')
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        ReservationCubit.get(context).fetchReservations(
            date: formatDate(widget.selectedDate),
            heureDebutTemps: formatTimeOfDay(widget.selectedTime),
            terrainId: widget.dropdownValue);
      });
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != widget.selectedTime) {
      setState(() {
        widget.selectedTime = picked;
        print(widget.selectedTime?.format(context));
        ReservationCubit.get(context).fetchReservations(
            date: formatDate(widget.selectedDate),
            heureDebutTemps: formatTimeOfDay(widget.selectedTime),
            terrainId: widget.dropdownValue);
      });
    }
  }
}
