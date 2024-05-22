import 'package:flutter/material.dart';
import 'package:pfeprojet/Model/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/addequipe.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/allequipe_detail.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/equipeimin_detail.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/myequipe_detail.dart';
import 'package:pfeprojet/screen/joueurScreens/equipe/update_equipe.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Equipe extends StatefulWidget {
  const Equipe({Key? key}) : super(key: key);

  @override
  State<Equipe> createState() => _EquipeState();
}

class _EquipeState extends State<Equipe> {
  late ScrollController _controller;
  bool vertial = false;
  List<bool> isSelected = [
    true,
    false,
    false,
    false
  ]; // State to control which view to show
  late final EquipeCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = EquipeCubit.get(context);
    cubit.getMyEquipe();
    _controller = ScrollController();
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange) {
          if (isSelected[0]) {
            if (EquipeCubit.get(context).cursorId != "") {
              EquipeCubit.get(context).getMyEquipe(
                  cursor: EquipeCubit.get(context).cursorId, vertial: vertial);
            }
          } else if (isSelected[1]) {
            if (EquipeCubit.get(context).cursorid != "") {
              EquipeCubit.get(context).getAllEquipe(
                  cursor: EquipeCubit.get(context).cursorid,
                  capitanId: HomeJoueurCubit.get(context).joueurModel!.id!);
              print('ggggg');
            }
          } else if (isSelected[2]) {
            if (EquipeCubit.get(context).cursorId1 != "") {
              EquipeCubit.get(context)
                  .getEquipeImIn(cursor: EquipeCubit.get(context).cursorId1);
              print('ggggg');
            }
          } else if (isSelected[3]) {
            if (EquipeCubit.get(context).cursorId2 != "") {
              EquipeCubit.get(context)
                  .getEquipeInvite(cursor: EquipeCubit.get(context).cursorId2);
              print('ggggg');
            }
          }
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    // Update all toggles based on the index
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      isSelected[buttonIndex] = buttonIndex == index;
                    }
                    if (index == 0) {
                      EquipeCubit.get(context).getMyEquipe(
                          vertial: vertial); // Fetch data for "My Equipes"
                    } else if (index == 1) {
                      EquipeCubit.get(context).getAllEquipe(
                          capitanId: HomeJoueurCubit.get(context)
                              .joueurModel!
                              .id!); // Fetch data for "All Equipes"
                    } else if (index == 2) {
                      EquipeCubit.get(context).getEquipeImIn();
                    } else if (index == 3) {
                      EquipeCubit.get(context).getEquipeInvite();
                    }
                  });
                },
                borderRadius: BorderRadius.circular(8),
                borderColor: Colors.blue,
                selectedBorderColor: Colors.blueAccent,
                selectedColor: Colors.white,
                fillColor: Colors.lightBlueAccent.withOpacity(0.5),
                constraints: const BoxConstraints(minHeight: 40.0),
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('My equipes'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('All Equipes'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Equipe im in'), // Label for the third button
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('les demandes'), // Label for the third button
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: isSelected[0]
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: BlocConsumer<EquipeCubit, EquipeState>(
                        listener: (context, state) {
                          if (state is DeleteEquipeStateGood) {
                            EquipeCubit.get(context)
                                .getMyEquipe(vertial: vertial)
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        builder: (context, state) {
                          if (state is GetMyEquipeLoading &&
                              EquipeCubit.get(context).cursorId == '') {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Vertial equipe :',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Checkbox(
                                      value: vertial,
                                      onChanged: (value) {
                                        setState(() {
                                          vertial = value!;
                                          EquipeCubit.get(context)
                                              .getMyEquipe(vertial: vertial);
                                        });
                                      }),
                                ],
                              ),
                              ListView.separated(
                                controller: _controller,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _buildEquipeItem(
                                      EquipeCubit.get(context)
                                          .equipeData[index],
                                      index,
                                      context,
                                      vertial);
                                },
                                separatorBuilder: (context, int index) =>
                                    const SizedBox(height: 16),
                                itemCount:
                                    EquipeCubit.get(context).equipeData.length,
                                shrinkWrap:
                                    true, // to prevent infinite height error
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : isSelected[1]
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: BlocConsumer<EquipeCubit, EquipeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is GetAllEquipeLoading &&
                                  EquipeCubit.get(context).cursorid == '') {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return ListView.separated(
                                controller: _controller,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _buildAllEquipeItem(
                                      EquipeCubit.get(context).equipes[index],
                                      index,
                                      context);
                                },
                                separatorBuilder: (context, int index) =>
                                    const SizedBox(height: 16),
                                itemCount:
                                    EquipeCubit.get(context).equipes.length,
                                shrinkWrap:
                                    true, // to prevent infinite height error
                              );
                            },
                          ),
                        )
                      : isSelected[2]
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: BlocConsumer<EquipeCubit, EquipeState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is GetEquipeImInLoading &&
                                      EquipeCubit.get(context).cursorId1 ==
                                          '') {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return ListView.separated(
                                    controller: _controller,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return _buildEquipeImInItem(
                                          EquipeCubit.get(context)
                                              .equipeImInData[index],
                                          index,
                                          context);
                                    },
                                    separatorBuilder: (context, int index) =>
                                        const SizedBox(height: 16),
                                    itemCount: EquipeCubit.get(context)
                                        .equipeImInData
                                        .length,
                                    shrinkWrap:
                                        true, // to prevent infinite height error
                                  );
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: BlocConsumer<EquipeCubit, EquipeState>(
                                listener: (context, state) async {
                                  if (state is AccepterInvStateGood) {
                                    await sendNotificationToJoueur(
                                        joueurId: state.joueurId,
                                        body:
                                            '${state.joueurname} a accepter votre invitation',
                                        title: 'invitation acceptée');
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GetEquipeInviteLoading &&
                                      EquipeCubit.get(context).cursorId2 ==
                                          '') {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return ListView.separated(
                                    controller: _controller,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return _buildEquipeInvitationItem(
                                          EquipeCubit.get(context)
                                              .equipeInviteData[index],
                                          index,
                                          context);
                                    },
                                    separatorBuilder: (context, int index) =>
                                        const SizedBox(height: 16),
                                    itemCount: EquipeCubit.get(context)
                                        .equipeInviteData
                                        .length,
                                    shrinkWrap:
                                        true, // to prevent infinite height error
                                  );
                                },
                              ),
                            )),
        ],
      ),
      floatingActionButton: isSelected[0]
          ? FloatingActionButton(
              onPressed: () {
                navigatAndReturn(context: context, page: AddEquipe());
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

//---------------------------- my team----------------------------------------------------------
  Widget _buildEquipeItem(
      EquipeData model, int index, BuildContext context, bool vertial) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyEquipeDetailsScreen(
                    equipeData: model,
                    vartial: vertial,
                  )),
        );
      },
      splashColor: Colors.transparent, // Prevents ripple effect on tap
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Team: ${model.nom}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Color(0xFF4CAF50)),
                onPressed: () {
                  navigatAndReturn(
                      context: context,
                      page: EditEquipe(equipeModel: model, vertial: vertial));
                  // Your code to handle edit action
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Color(0xFFF44336)),
                onPressed: () {
                  dialogDelete(context, model);
                  // Your code to handle delete action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  //--------------------------------------alallllllllllllllllllllllllllllllllllll-----------------------

  Widget _buildAllEquipeItem(
      EquipeData model, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your onTap functionality here if needed
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AllEquipeDetailsScreen(equipes: model)),
        );
      },
      splashColor: Colors.transparent, // Prevents ripple effect on tap
      highlightColor: Colors.transparent, // Prevents highlight effect on tap
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Team: ${model.nom}', // Displaying the team name
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone_in_talk, color: Colors.green),
                    onPressed: () {
                      int? phoneNumber = model.capitaineId.telephone;
                      if (phoneNumber != null) {
                        _makePhoneCall(phoneNumber.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("No telephone number available."),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Capitaine: ${model.capitaineId.username}', // Displaying the captain's name
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${model.joueurs.length}/${model.numeroJoueurs}', // Showing the ratio of players to total slots
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------equipes im in ----------------------------------------------------

  Widget _buildEquipeImInItem(
      EquipeData model, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your onTap functionality here if needed
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EquipeImInDetailsScreen(equipeImInData: model)),
        );
      },
      splashColor: Colors.transparent, // Prevents ripple effect on tap
      highlightColor: Colors.transparent, // Prevents highlight effect on tap
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Team: ${model.nom}', // Displaying the team name
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone_in_talk, color: Colors.green),
                    onPressed: () {
                      int? phoneNumber = model.capitaineId.telephone;
                      if (phoneNumber != null) {
                        _makePhoneCall(phoneNumber.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("No telephone number available."),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Capitaine: ${model.capitaineId.username}', // Displaying the captain's name
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${model.joueurs.length}/${model.numeroJoueurs}', // Showing the ratio of players to total slots
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //------------------------------------- invitation--------------------------------------------------

  Widget _buildEquipeInvitationItem(
      EquipeData model, int index, BuildContext context) {
    // String joueurId, String equipename,
    return InkWell(
      onTap: () {
        // Add your onTap functionality here if needed
      },
      splashColor: Colors.transparent, // Prevents ripple effect on tap
      highlightColor: Colors.transparent, // Prevents highlight effect on tap
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Team: ${model.nom}', // Displaying the team name
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Add your acce
                        EquipeCubit.get(context)
                            .accepterInvitation(
                                id: model.id,
                                joueurId: model.capitaineId.id,
                                joueurname: HomeJoueurCubit.get(context)
                                    .joueurModel!
                                    .username!)
                            .then((_) {
                          showToast(
                              msg: "Invitation accepted",
                              state: ToastStates.success);
                          EquipeCubit.get(context)
                              .getEquipeInvite(); // Refresh the list after accepting
                        }).catchError((error) {
                          showToast(
                              msg: "Failed to accept invitation",
                              state: ToastStates.error);
                        });
                      },
                      child: Text('Accepter', style: TextStyle(fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // foreground
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                      )),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      EquipeCubit.get(context)
                          .refuserInvitation(id: model.id)
                          .then((_) {
                        showToast(
                            msg: "Invitation refused",
                            state: ToastStates.success);
                        EquipeCubit.get(context)
                            .getEquipeInvite(); // Refresh the list after refusing
                      }).catchError((error) {
                        showToast(
                            msg: "Failed to refuse invitation",
                            state: ToastStates.error);
                      });
                    },
                    iconSize: 24,
                    padding: EdgeInsets.all(4),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Capitaine: ${model.capitaineId.username}', // Displaying the captain's name
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${model.joueurs.length}/${model.numeroJoueurs}', // Showing the ratio of players to total slots
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone_in_talk, color: Colors.green),
                    onPressed: () {
                      int? phoneNumber = model.capitaineId.telephone;
                      if (phoneNumber != null) {
                        _makePhoneCall(phoneNumber.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("No telephone number available."),
                          ),
                        );
                      }
                    },
                    iconSize: 24,
                    padding: EdgeInsets.all(4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------dialog---------------------------------------------------

  Future<dynamic> dialogDelete(BuildContext context, EquipeData model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Equipe'),
          content: const Text('Are you sure you want to delete this equipe?'),
          actions: [
            TextButton(
              onPressed: () {
                EquipeCubit.get(context).deleteEquipe(id: model.id!);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

//-------------------------------------------- phone call--------------------------------------------------------
  Future<void> _makePhoneCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      await Permission.phone.request();
    }

    if (await Permission.phone.isGranted) {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      await launchUrl(launchUri);
    } else {
      print('Permission denied');
    }
  }
}
