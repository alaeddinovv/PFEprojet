import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/reservation_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/profile_other.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

class DetailOtherReserve extends StatefulWidget {
  final DateTime jour;
  final String heure;
  final String terrainId;

  DetailOtherReserve({
    super.key,
    required this.jour,
    required this.heure,
    required this.terrainId,
  });

  @override
  State<DetailOtherReserve> createState() => _DetailOtherReserveState();
}

class _DetailOtherReserveState extends State<DetailOtherReserve> {
  late final TerrainCubit cubit;

  ReservationModel? reservation;
  List<String>? equipe1Joueurs = [];
  List<String>? equipe1JoueursAttend = [];

  @override
  void initState() {
    cubit = TerrainCubit.get(context);
    print(widget.jour);
    cubit.getOtherreserve(
      date: widget.jour,
      heure_debut_temps: widget.heure,
      terrainId: widget.terrainId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TerrainCubit, TerrainState>(
            listener: (BuildContext context, TerrainState state) {
          if (state is GetJouerByUsernameStateGood) {
            navigatAndReturn(
                context: context,
                page: OtherJoueurDetails(
                  joueurModel: state.dataJoueurModel,
                  showTelephone: false,
                ));
          }
        }, builder: (context, state) {
          if (state is GetOtherReserveLoading) {
            return const Center(child: LinearProgressIndicator());
          }
          if (state is GetOtherReserveStateBad) {
            return const Center(child: Text('Error'));
          }
          if (state is GetOtherReserveStateGood) {
            reservation = state.reservations;
            equipe1Joueurs =
                state.reservations.equipe1?.joueurs!.map((e) => e.id!).toList();
            equipe1JoueursAttend = state.reservations.equipe1?.attenteJoueurs!
                .map((e) => e.id!)
                .toList();
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                Text(
                  S.of(context).reservationDetails,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: ListTile(
                          // leading:
                          //     Icon(Icons.calendar_today, color: greenConst),
                          title: Text(
                            DateFormat('yy-MM-dd').format(reservation!.jour!)!,
                            // style: const TextStyle(fontSize: 20.0),
                          ),
                          subtitle: Text(S.of(context).date),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: ListTile(
                          // leading: Icon(Icons.access_time, color: greenConst),
                          title: Text(reservation!.heureDebutTemps!),
                          subtitle: Text(S.of(context).time),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: ListTile(
                          // leading: Icon(Icons.timer, color: greenConst),
                          title: Text(reservation!.duree.toString()),
                          subtitle: Text(S.of(context).weeks),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  '${S.of(context).yourTeam} : (${reservation!.equipe1 != null ? reservation!.equipe1!.nom : S.of(context).noTeam})',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                reservation!.equipe1 != null
                    ? Card(
                        child: Column(
                          children: List.generate(
                            reservation!.equipe1!.numeroJoueurs!,
                            (index) {
                              return ListTile(
                                leading: Icon(Icons.person, color: greenConst),
                                title: index <
                                        reservation!.equipe1!.joueurs!.length
                                    ? InkWell(
                                        child: Text(reservation!.equipe1!
                                            .joueurs![index].username!),
                                        onTap: () {
                                          cubit.getJouerbyName(
                                              username: reservation!.equipe1!
                                                  .joueurs![index].username!);
                                        },
                                      )
                                    : index <
                                            reservation!
                                                    .equipe1!.joueurs!.length +
                                                reservation!.equipe1!
                                                    .attenteJoueurs!.length
                                        ? Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  cubit.getJouerbyName(
                                                      username: reservation!
                                                          .equipe1!
                                                          .attenteJoueurs![
                                                              index -
                                                                  reservation!
                                                                      .equipe1!
                                                                      .joueurs!
                                                                      .length]
                                                          .username!);
                                                },
                                                child: Text(reservation!
                                                    .equipe1!
                                                    .attenteJoueurs![index -
                                                        reservation!.equipe1!
                                                            .joueurs!.length]
                                                    .username!),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Icon(Icons.hourglass_empty,
                                                  color: greenConst),
                                            ],
                                          )
                                        : Text(
                                            S.of(context).notAssignedYet,
                                            style: TextStyle(color: Colors.red),
                                          ),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(child: Text(S.of(context).youDontHaveTeamYet)),
                const SizedBox(height: 20.0),
                Text(
                  "${S.of(context).opponentsTeam} : (${reservation!.equipe2 != null ? reservation!.equipe2!.nom : S.of(context).noOpponentTeamYet})",
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                reservation!.equipe2 != null
                    ? Card(
                        child: Column(
                          children: List.generate(
                            reservation!.equipe2!.numeroJoueurs!,
                            (index) {
                              return ListTile(
                                leading:
                                    const Icon(Icons.person, color: Colors.red),
                                title: index <
                                        reservation!.equipe2!.joueurs!.length
                                    ? InkWell(
                                        onTap: () {
                                          cubit.getJouerbyName(
                                              username: reservation!.equipe2!
                                                  .joueurs![index].username!);
                                        },
                                        child: Text(reservation!.equipe2!
                                            .joueurs![index].username!),
                                      )
                                    : Text(
                                        S.of(context).notAssignedYet,
                                        style: TextStyle(color: Colors.red),
                                      ),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(child: Text(S.of(context).noOpponentTeamYet)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
