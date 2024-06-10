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
  late final ReservationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ReservationCubit.get(context);
    cubit.fetchReservations();
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
        } else if (state is AddReservationStateGood) {
          setState(() {
            cubit.fetchReservations(
                date: formatDate(widget.selectedDate),
                heureDebutTemps: formatTimeOfDay(widget.selectedTime),
                terrainId: widget.dropdownValue);
          });
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_today,
                            color: Colors.white),
                        label: Text(
                          'Sélectionner un jour',
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0XFF76A26C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => selectDate(),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon:
                            const Icon(Icons.access_time, color: Colors.white),
                        label: const Text(
                          'Sélectionner une heure',
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0XFF76A26C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => selectTime(),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('Nom du stade :'),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0XFF76A26C), width: 2),
                    ),
                    child: DropdownButton<String>(
                      value: widget.dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Color(0XFF76A26C)),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.dropdownValue = newValue!;
                          cubit.fetchReservations(
                            date: formatDate(widget.selectedDate),
                            heureDebutTemps:
                                formatTimeOfDay(widget.selectedTime),
                            terrainId: widget.dropdownValue,
                          );
                        });
                      },
                      items: TerrainCubit.TerrainCubit.get(context)
                          .terrains
                          .map<DropdownMenuItem<String>>(
                              (TerrainModel terrain) {
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
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    if (widget.selectedDate != null)
                      Chip(
                        label: Text(
                            'Jour: ${widget.selectedDate?.day.toString().padLeft(2, "0")}/${widget.selectedDate?.month.toString().padLeft(2, "0")}/${widget.selectedDate?.year}'),
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
                        deleteButtonTooltipMessage: 'Supprimer ce jour',
                      ),
                    if (widget.selectedTime != null)
                      Chip(
                        label: Text(
                            'Heure: ${widget.selectedTime!.hour.toString().padLeft(2, '0')}:${widget.selectedTime!.minute.toString().padLeft(2, '0')}'),
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
                        deleteButtonTooltipMessage: 'Supprimer cette heure',
                      ),
                    if (widget.nameOfTerrain != null)
                      Chip(
                        label: Text('Stade: ${widget.nameOfTerrain}'),
                        deleteIcon: const Icon(
                          Icons.cancel,
                        ),
                        onDeleted: () {
                          setState(() {
                            widget.dropdownValue = null;
                            widget.nameOfTerrain = null;
                            cubit.fetchReservations(
                                date: formatDate(widget.selectedDate),
                                heureDebutTemps:
                                    formatTimeOfDay(widget.selectedTime),
                                terrainId: widget.dropdownValue);
                          });
                        },
                        deleteIconColor: Colors.redAccent,
                        deleteButtonTooltipMessage: 'Supprimer ce stade',
                      ),
                  ],
                ),
              ),
              BlocBuilder<ReservationCubit, ReservationState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: cubit.reservationList.length,
                    itemBuilder: (context, index) {
                      var reservation = cubit.reservationList[index];
                      return Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    '${reservation.jour!.month.toString().padLeft(2, '0')}/${reservation.jour!.day.toString().padLeft(2, '0')}  à ${reservation.heureDebutTemps}'),
                              ),
                              Text(
                                reservation.terrainId!.nom.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF76A26C)),
                              )
                            ],
                          ),
                          subtitle: Text(
                              'Durée: ${reservation.duree} semaine(s), État: ${reservation.etat}\n Nom d\'utilisateur: ${reservation.joueurId!.username}'),
                          onTap: () {
                            navigatAndReturn(
                                context: context,
                                page: ReservationDetailsScreen(
                                    reservation: reservation));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              if (cubit.state is GetReservationLoadingState &&
                  cubit.cursorId != '')
                const Center(
                  child: CircularProgressIndicator(color: Color(0XFF76A26C)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      locale: const Locale('fr'), // Set the locale to French
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
      helpText: 'Sélectionner une heure', // Set the help text in French
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
