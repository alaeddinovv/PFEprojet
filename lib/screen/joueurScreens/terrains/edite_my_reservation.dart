import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/reservation_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/component/search_equipe.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/component/searchJoueur.dart';

class DetailMyReserve extends StatefulWidget {
  final DateTime jour;
  final String heure;
  final String terrainId;
  final TextEditingController equipeIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  DetailMyReserve(
      {super.key,
      required this.jour,
      required this.heure,
      required this.terrainId});

  @override
  State<DetailMyReserve> createState() => _DetailMyReserveState();
}

class _DetailMyReserveState extends State<DetailMyReserve> {
  bool isEditeEquipe1 = false;
  bool isEditeEquipe2 = false;
  bool isSomthingChanged = false;
  late final TerrainCubit cubit;

  final TextEditingController equipeIdController = TextEditingController();

  ReservationModel? reservation;
  List<String>? equipe1Joueurs = [];
  List<String>? equipe2Joueurs = [];
  bool updateAllWeeks = true;
  @override
  void initState() {
    cubit = TerrainCubit.get(context);
    print(widget.jour);
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
        title: const Text('edite Reservation'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<TerrainCubit, TerrainState>(
          listener: (context, state) {
            if (state is GetMyReserveStateGood) {
              reservation = state.reservations;
              equipe1Joueurs = state.reservations.equipe1?.joueurs!
                  .map((e) => e.id!)
                  .toList();
              equipe2Joueurs = state.reservations.equipe2?.joueurs!
                  .map((e) => e.id!)
                  .toList();
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
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Text(
                    S.of(context).reservationDetails,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    child: ListTile(
                        leading: Icon(Icons.calendar_today, color: greenConst),
                        title: Text(formatDate(reservation!.jour!)!,
                            style: const TextStyle(fontSize: 20.0)),
                        subtitle: Text(S.of(context).date)),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_time, color: greenConst),
                      title: Text(reservation!.heureDebutTemps!),
                      subtitle: Text(S.of(context).time),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.timer, color: greenConst),
                      title: Text(reservation!.duree.toString()),
                      subtitle: Text(S.of(context).weeks),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Team Details
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${S.of(context).yourTeam} : (${reservation!.equipe1 != null ? reservation!.equipe1!.nom : S.of(context).noTeam})',
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isEditeEquipe1 = !isEditeEquipe1;
                                    isSomthingChanged = true;
                                  });
                                },
                                icon: Icon(
                                  isEditeEquipe1 ? Icons.done : (Icons.edit),
                                  color: greenConst,
                                )),
                          ],
                        ),
                        TextButton(
                          child: Text(S.of(context).changeTeam),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(S
                                                .of(context)
                                                .forAllReservations),
                                            onTap: () {
                                              updateAllWeeks = true;
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SearchEquipe(
                                                          isOnlyMy: true,
                                                          equipeIdController:
                                                              equipeIdController,
                                                          onEquipeSelected:
                                                              (equipe) {
                                                            setState(() {
                                                              reservation!
                                                                      .equipe1 =
                                                                  equipe;
                                                              equipe1Joueurs =
                                                                  equipe
                                                                      .joueurs!
                                                                      .map((e) =>
                                                                          e.id!)
                                                                      .toList();
                                                              isSomthingChanged =
                                                                  true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          ListTile(
                                            title: Text(S
                                                .of(context)
                                                .forThisReservationOnly),
                                            onTap: () {
                                              updateAllWeeks = false;
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SearchEquipe(
                                                          isOnlyMy: true,
                                                          equipeIdController:
                                                              equipeIdController,
                                                          onEquipeSelected:
                                                              (equipe) {
                                                            setState(() {
                                                              reservation!
                                                                      .equipe1 =
                                                                  equipe;
                                                              equipe1Joueurs =
                                                                  equipe
                                                                      .joueurs!
                                                                      .map((e) =>
                                                                          e.id!)
                                                                      .toList();
                                                            });
                                                            isSomthingChanged =
                                                                true;
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          ListTile(
                                            title:
                                                Text(S.of(context).removeTeam),
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: const Text(
                                                            'remove equipe'),
                                                        content: Text(S
                                                            .of(context)
                                                            .removeTeamConfirmation),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(S
                                                                .of(context)
                                                                .no),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                reservation!
                                                                        .equipe1 =
                                                                    null;
                                                                isSomthingChanged =
                                                                    true;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(S
                                                                .of(context)
                                                                .yes),
                                                          ),
                                                        ],
                                                      ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ),
                  reservation!.equipe1 != null
                      ? Card(
                          child: Column(
                            children: List.generate(
                                reservation!.equipe1!.numeroJoueurs!, (index) {
                              return ListTile(
                                leading: Icon(Icons.person, color: greenConst),
                                trailing: isEditeEquipe1
                                    ? index <
                                            reservation!
                                                .equipe1!.joueurs!.length
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit,
                                                    color: greenConst),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 300,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Dialog(
                                                            child: SearchJoueur(
                                                              userIdController:
                                                                  widget
                                                                      .userIdController,
                                                              onEquipeSelected:
                                                                  (joueur) {
                                                                setState(() {
                                                                  reservation!
                                                                          .equipe1!
                                                                          .joueurs![
                                                                      index] = joueur;
                                                                  isSomthingChanged =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.clear,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    reservation!
                                                        .equipe1!.joueurs!
                                                        .removeAt(index);
                                                    isSomthingChanged = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.add,
                                                    color: greenConst),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 300,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Dialog(
                                                            child: SearchJoueur(
                                                              userIdController:
                                                                  widget
                                                                      .userIdController,
                                                              onEquipeSelected:
                                                                  (joueur) {
                                                                setState(() {
                                                                  reservation!
                                                                      .equipe1!
                                                                      .joueurs!
                                                                      .add(
                                                                          joueur);
                                                                  isSomthingChanged =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          )
                                    : const SizedBox(),
                                title: index <
                                        reservation!.equipe1!.joueurs!.length
                                    ? Text(reservation!
                                        .equipe1!.joueurs![index].username!)
                                    : index <
                                            reservation!
                                                    .equipe1!.joueurs!.length +
                                                reservation!.equipe1!
                                                    .attenteJoueurs!.length
                                        ? Row(
                                            children: [
                                              Text(reservation!
                                                  .equipe1!
                                                  .attenteJoueurs![index -
                                                      reservation!.equipe1!
                                                          .joueurs!.length]
                                                  .username!),
                                              Spacer(),
                                              Icon(
                                                Icons.hourglass_empty,
                                                color: Colors
                                                    .blue, // Blue color to signify ongoing progress
                                                size: 24,
                                              )
                                            ],
                                          )
                                        : Text(
                                            S.of(context).notAssignedYet,
                                            style: TextStyle(color: Colors.red),
                                          ),
                              );
                            }),
                          ),
                        )
                      : Center(child: Text(S.of(context).youDontHaveTeamYet)),
                  const SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${S.of(context).opponentsTeam} : (${reservation!.equipe2 != null ? reservation!.equipe2!.nom : S.of(context).noOpponentTeamYet})",
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isEditeEquipe2 = !isEditeEquipe2;
                                    isSomthingChanged = true;
                                  });
                                },
                                icon: Icon(
                                  isEditeEquipe2 ? Icons.done : (Icons.edit),
                                  color: greenConst,
                                )),
                          ],
                        ),
                        TextButton(
                          child: Text(S.of(context).changeTeam),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(S.of(context).choose),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: const Text(
                                                'for all reservation'),
                                            onTap: () {
                                              updateAllWeeks = true;
                                              Navigator.pop(context);

                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SearchEquipe(
                                                          isOnlyMy: false,
                                                          equipeIdController:
                                                              equipeIdController,
                                                          onEquipeSelected:
                                                              (equipe) {
                                                            setState(() {
                                                              reservation!
                                                                      .equipe2 =
                                                                  equipe;
                                                              equipe2Joueurs =
                                                                  equipe
                                                                      .joueurs!
                                                                      .map((e) =>
                                                                          e.id!)
                                                                      .toList();
                                                              isSomthingChanged =
                                                                  true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          ListTile(
                                            title: const Text(
                                                'for this reservation only'),
                                            onTap: () {
                                              updateAllWeeks = false;
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SearchEquipe(
                                                          isOnlyMy: false,
                                                          equipeIdController:
                                                              equipeIdController,
                                                          onEquipeSelected:
                                                              (equipe) {
                                                            setState(() {
                                                              reservation!
                                                                      .equipe2 =
                                                                  equipe;
                                                              equipe2Joueurs =
                                                                  equipe
                                                                      .joueurs!
                                                                      .map((e) =>
                                                                          e.id!)
                                                                      .toList();
                                                            });
                                                            isSomthingChanged =
                                                                true;
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          ListTile(
                                            title: const Text('remove equipe'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: const Text(
                                                            'remove equipe'),
                                                        content: const Text(
                                                            'Are you sure you want to remove your team from this reservation?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                reservation!
                                                                        .equipe2 =
                                                                    null;
                                                                isSomthingChanged =
                                                                    true;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                        ],
                                                      ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ),
                  // Display opponent's team list
                  reservation!.equipe2 != null
                      ? Card(
                          child: Column(
                            children: List.generate(
                                reservation!.equipe2!.numeroJoueurs!, (index) {
                              return ListTile(
                                leading:
                                    const Icon(Icons.person, color: Colors.red),
                                trailing: isEditeEquipe2
                                    ? index <
                                            reservation!
                                                .equipe2!.joueurs!.length
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit,
                                                    color: greenConst),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 300,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Dialog(
                                                            child: SearchJoueur(
                                                              userIdController:
                                                                  widget
                                                                      .userIdController,
                                                              onEquipeSelected:
                                                                  (joueur) {
                                                                setState(() {
                                                                  reservation!
                                                                          .equipe2!
                                                                          .joueurs![
                                                                      index] = joueur;
                                                                  isSomthingChanged =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.clear,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    reservation!
                                                        .equipe2!.joueurs!
                                                        .removeAt(index);
                                                    isSomthingChanged = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.add,
                                                    color: greenConst),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 300,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Dialog(
                                                            child: SearchJoueur(
                                                              userIdController:
                                                                  widget
                                                                      .userIdController,
                                                              onEquipeSelected:
                                                                  (joueur) {
                                                                setState(() {
                                                                  reservation!
                                                                      .equipe2!
                                                                      .joueurs!
                                                                      .add(
                                                                          joueur);
                                                                  isSomthingChanged =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          )
                                    : const SizedBox(),
                                title: index <
                                        reservation!.equipe2!.joueurs!.length
                                    ? Text(reservation!
                                        .equipe2!.joueurs![index].username!)
                                    : Text(
                                        S.of(context).notAssignedYet,
                                        style: TextStyle(color: Colors.red),
                                      ),
                              );
                            }),
                          ),
                        )
                      : Center(child: Text(S.of(context).noOpponentTeamYet)),

                  const SizedBox(height: 20.0),
                  state is ConfirmConnectEquipeLoading
                      ? const Center(child: CircularProgressIndicator())
                      : defaultSubmit2(
                          text: S.of(context).confirmConnection,
                          onPressed: () async {
                            // if (deletedJoueurs1.isNotEmpty) {
                            //   print(
                            //       'The following joueurs have been deleted from Equipe 1:');
                            //   deletedJoueurs1.forEach((joueurId) {
                            //     print('- $joueurId');
                            //   });
                            // } else {
                            //   print(
                            //       'No joueurs have been deleted from Equipe 1.');
                            // }

                            // if (addedJoueurs1.isNotEmpty) {
                            //   print(
                            //       'The following joueurs have been added to Equipe 1:');
                            //   addedJoueurs1.forEach((joueurId) {
                            //     print('- $joueurId');
                            //   });
                            // } else {
                            //   print(
                            //       'No new joueurs have been added to Equipe 1.');
                            // }

                            // if (deletedJoueurs2.isNotEmpty) {
                            //   print(
                            //       'The following joueurs have been deleted from Equipe 2:');
                            //   deletedJoueurs2.forEach((joueurId) {
                            //     print('- $joueurId');
                            //   });
                            // } else {
                            //   print(
                            //       'No joueurs have been deleted from Equipe 2.');
                            // }

                            // if (addedJoueurs2.isNotEmpty) {
                            //   print(
                            //       'The following joueurs have been added to Equipe 2:');
                            //   addedJoueurs2.forEach((joueurId) {
                            //     print('- $joueurId');
                            //   });
                            // } else {
                            //   print(
                            //       'No new joueurs have been added to Equipe 2.');
                            // }

                            bool isEquialEquipe1 = eq(
                                equipe1Joueurs,
                                reservation?.equipe1?.joueurs!
                                    .map((e) => e.id!)
                                    .toList());
                            bool isEquialEquipe2 = eq(
                                equipe2Joueurs,
                                reservation?.equipe2?.joueurs!
                                    .map((e) => e.id!)
                                    .toList());
                            print(isEquialEquipe1);
                            print(isEquialEquipe2);
                            if (isEquialEquipe1 && isEquialEquipe2) {
                              if (!isSomthingChanged) {
                                //this bool for change equipe button
                                showToast(
                                    msg: S.of(context).noChangesDetected,
                                    state: ToastStates.error);
                                return;
                              }
                              cubit.confirmConnectEquipe(
                                updateAllWeeks: updateAllWeeks,
                                reservationGroupId:
                                    reservation?.reservationGroupId,
                                reservationId: reservation?.id,
                                equipe1: reservation?.equipe1?.id,
                                equipe2: reservation?.equipe2?.id,
                              );
                            } else {
                              Map<String, List<String>> changedJoueurs1 =
                                  findChangedJoueurs(
                                      equipe1Joueurs,
                                      reservation?.equipe1?.joueurs!
                                          .map((e) => e.id!)
                                          .toList());
                              Map<String, List<String>> changedJoueurs2 =
                                  findChangedJoueurs(
                                      equipe2Joueurs,
                                      reservation?.equipe2?.joueurs!
                                          .map((e) => e.id!)
                                          .toList());

                              List<String> deletedJoueurs1 =
                                  changedJoueurs1['deleted'] ?? [];
                              List<String> addedJoueurs1 =
                                  changedJoueurs1['added'] ?? [];
                              List<String> deletedJoueurs2 =
                                  changedJoueurs2['deleted'] ?? [];
                              List<String> addedJoueurs2 =
                                  changedJoueurs2['added'] ?? [];
                              Map<String, dynamic> model1 = {
                                "nom": reservation?.equipe1?.nom,
                                "numero_joueurs":
                                    reservation?.equipe1?.numeroJoueurs,
                                "wilaya": reservation?.equipe1?.wilaya,
                                "joueurs": reservation?.equipe1?.joueurs!
                                    .map((e) => e.id!)
                                    .toList(),
                                "commune": reservation?.equipe1?.commune,
                              };
                              Map<String, dynamic> model2 = {
                                "nom": reservation?.equipe2?.nom,
                                "numero_joueurs":
                                    reservation?.equipe2?.numeroJoueurs,
                                "wilaya": reservation?.equipe2?.wilaya,
                                "joueurs": reservation?.equipe2?.joueurs!
                                    .map((e) => e.id!)
                                    .toList(),
                                "commune": reservation?.equipe2?.commune,
                              };
                              print(model1);
                              print(model2);
                              if (!isEquialEquipe1 && !isEquialEquipe2) {
                                cubit
                                    .createEquipeVertial(
                                        model: model1, isMyEquipe: true)
                                    .then((value) {
                                  cubit
                                      .createEquipeVertial(
                                          model: model2, isMyEquipe: false)
                                      .then((value) {
                                    cubit.confirmConnectEquipe(
                                      updateAllWeeks: false,
                                      reservationId: reservation!.id,
                                      equipe1: cubit.idEquipe1Vertial ??
                                          reservation?.equipe1?.id,
                                      equipe2: cubit.idEquipe2Vertial ??
                                          reservation?.equipe2?.id,
                                    );
                                  });
                                });
                              } else if (!isEquialEquipe1) {
                                print("!isEquialEquipe1");
                                cubit
                                    .createEquipeVertial(
                                        model: model1, isMyEquipe: true)
                                    .then((value) {
                                  cubit.confirmConnectEquipe(
                                    updateAllWeeks: false,
                                    reservationId: reservation!.id,
                                    equipe1: cubit.idEquipe1Vertial ??
                                        reservation?.equipe1?.id,
                                    equipe2: reservation?.equipe2?.id,
                                  );
                                });
                              } else if (!isEquialEquipe2) {
                                cubit
                                    .createEquipeVertial(
                                        model: model2, isMyEquipe: false)
                                    .then((value) {
                                  cubit.confirmConnectEquipe(
                                    updateAllWeeks: false,
                                    reservationId: reservation!.id,
                                    equipe1: reservation?.equipe1?.id,
                                    equipe2: cubit.idEquipe2Vertial ??
                                        reservation?.equipe2?.id,
                                  );
                                });
                              }
                              // cubit.createEquipeVertial()
                            }
                          },
                          background: greenConst),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
