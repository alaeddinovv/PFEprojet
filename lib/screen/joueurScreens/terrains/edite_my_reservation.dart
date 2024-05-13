import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/reservation_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/component/search_my_equipe.dart';
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  'Reservation Details',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
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
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.green),
                    title: Text(reservation!.heureDebutTemps!),
                    subtitle: const Text('Time'),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.timer, color: Colors.green),
                    title: Text(reservation!.duree.toString()),
                    subtitle: const Text('semaines'),
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
                            'Your Team : (${reservation!.equipe1 != null ? reservation!.equipe1!.nom : 'No team'})',
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
                                color: Colors.green,
                              )),
                        ],
                      ),
                      TextButton(
                        child: const Text('change equipe'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text(
                                              'for all reservations'),
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
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                equipe.joueurs!
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
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                equipe.joueurs!
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
                                                          child:
                                                              const Text('No'),
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
                                                          child:
                                                              const Text('Yes'),
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
                              leading:
                                  const Icon(Icons.person, color: Colors.green),
                              trailing: isEditeEquipe1
                                  ? index <
                                          reservation!.equipe1!.joueurs!.length
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.green),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Dialog(
                                                          child: SearchJoueur(
                                                            userIdController: widget
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
                                                  reservation!.equipe1!.joueurs!
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
                                              icon: const Icon(Icons.add,
                                                  color: Colors.green),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Dialog(
                                                          child: SearchJoueur(
                                                            userIdController: widget
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Opponent's Team : (${reservation!.equipe2 != null ? reservation!.equipe2!.nom : 'No team'})",
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
                                color: Colors.green,
                              )),
                        ],
                      ),
                      TextButton(
                        child: const Text('change equipe'),
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
                                            updateAllWeeks = true;
                                            Navigator.pop(context);

                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                equipe.joueurs!
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
                                                          child:
                                                              const Text('No'),
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
                                                          child:
                                                              const Text('Yes'),
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
                                          reservation!.equipe2!.joueurs!.length
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.green),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Dialog(
                                                          child: SearchJoueur(
                                                            userIdController: widget
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
                                                  reservation!.equipe2!.joueurs!
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
                                              icon: const Icon(Icons.add,
                                                  color: Colors.green),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 300,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Dialog(
                                                          child: SearchJoueur(
                                                            userIdController: widget
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
                              title:
                                  index < reservation!.equipe2!.joueurs!.length
                                      ? Text(reservation!
                                          .equipe2!.joueurs![index].username!)
                                      : const Text(
                                          'Not assigned yet',
                                          style: TextStyle(color: Colors.red),
                                        ),
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
                        onPressed: () async {
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
                              showToast(
                                  msg: 'no changes detected',
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
                        background: Colors.green),
              ],
            );
          },
        ),
      ),
    );
  }
}
