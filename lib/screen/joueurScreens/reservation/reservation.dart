import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/cubit/reservation_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/reservation/equipe_reserve_details.dart';
import 'package:pfeprojet/generated/l10n.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
          if (ReservationJoueurCubit.get(context).cursorid != "") {
            print('ffff');
            ReservationJoueurCubit.get(context).getEquipesDemander(
                cursor: ReservationJoueurCubit.get(context).cursorid);
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EquipeCubit, EquipeState>(
      listener: (context, state) {
        if (state is AnnulerRejoindreEquipeStateGood) {
          cubit.getEquipesDemander();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            BlocConsumer<ReservationJoueurCubit, ReservationJoueurState>(
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
                                    '${S.of(context).number_of_players}: ${equipe.numeroJoueurs}'),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EquipeReserveDetials(equipe: equipe),
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
      ),
    );
  }
}
