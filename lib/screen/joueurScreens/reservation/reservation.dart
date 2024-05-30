import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/tpggleButtons.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/equipe_reserve_details.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  bool _showList = true;
  late ReservationJoueurCubit cubit;
  late ScrollController _controller;

  @override
  void initState() {
    cubit = ReservationJoueurCubit.get(context);
    cubit.getEquipesDemander();

    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange) {
          if (_showList) {
            if (ReservationJoueurCubit.get(context).cursorid != "") {
              print('ffff');
              ReservationJoueurCubit.get(context).getEquipesDemander(
                  cursor: ReservationJoueurCubit.get(context).cursorid);
            }
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child:
                //  ToggleButtons(
                //   isSelected: [_showList, !_showList],
                //   onPressed: (int index) {
                //     setState(() {
                //       _showList = index == 0;
                //       if (!_showList) {
                //         ReservationJoueurCubit.get(context).getEquipesDemander(
                //             cursor: ReservationJoueurCubit.get(context).cursorid);
                //       } else {}
                //     });
                //   },
                //   borderRadius: BorderRadius.circular(8),
                //   borderColor: Colors.blue,
                //   selectedBorderColor: Colors.blueAccent,
                //   selectedColor: Colors.white,
                //   fillColor: Colors.lightBlueAccent.withOpacity(0.5),
                //   constraints: const BoxConstraints(minHeight: 40.0),
                //   children: const <Widget>[
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16),
                //       child: Text('Reservations Terrain'),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16),
                //       child: Text('Demander equipe'),
                //     ),
                //   ],
                // ),
                ToggleButtonsWidget(
              icon1: Icons.list_outlined,
              icon2: Icons.list_outlined,
              text1: 'Reservations Terrain',
              text2: 'Demander equipe',
              showList: _showList,
              onToggle: (value) {
                setState(() {
                  _showList = value;
                  if (!_showList) {
                    ReservationJoueurCubit.get(context).getEquipesDemander(
                        cursor: ReservationJoueurCubit.get(context).cursorid);
                  } else {}
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          // Reservations or Demands List
          _showList
              ? const Text('Reservations List Terrain')
              : BlocConsumer<ReservationJoueurCubit, ReservationJoueurState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetAllEquipeDemanderLoading &&
                        cubit.cursorid == '') {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _controller,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.equipesdemander.length,
                              itemBuilder: (context, index) {
                                final equipe = cubit.equipesdemander[index];
                                return Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: ListTile(
                                    leading: const Icon(Icons.group),
                                    title: Text(equipe.nom ?? ''),
                                    subtitle: Text(
                                        'Number of Players: ${equipe.numeroJoueurs}'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EquipeReserveDetials(
                                                  equipe: equipe),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          if (state is GetAllEquipeDemanderLoading &&
                              cubit.cursorid != '')
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
}
