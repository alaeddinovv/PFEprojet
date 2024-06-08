import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'cubit/equipe_cubit.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';

class AddEquipe extends StatefulWidget {
  AddEquipe({Key? key}) : super(key: key);

  @override
  _AddEquipeState createState() => _AddEquipeState();
}

class _AddEquipeState extends State<AddEquipe> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final wilayaController = TextEditingController();
  final dairaController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? selectedWilaya;
  List<dynamic> wilayas = [];

  @override
  void initState() {
    super.initState();
    loadWilayas();
  }

  void loadWilayas() {
    final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
    });
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Créer une équipe"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<EquipeCubit, EquipeState>(
                    builder: (context, state) {
                      if (state is CreerEquipeLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox(height: 30);
                    },
                  ),
                  defaultForm3(
                    context: context,
                    controller: _typeController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Le nom de l\'équipe ne doit pas être vide';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    labelText: "Nom de l'équipe",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _numberController,
                    type: TextInputType.number,
                    labelText: "Nombre de joueurs",
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Le nombre de joueurs ne doit pas être vide';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.format_list_numbered_rounded,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  DropdownScreen(
                    selectedDaira: dairaController,
                    selectedWilaya: wilayaController,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<EquipeCubit, EquipeState>(
                      listener: (context, state) {
                        if (state is CreerEquipeLoadingState) {
                          canPop = false;
                        } else {
                          canPop = true;
                        }
                        if (state is CreerEquipeStateGood) {
                          showToast(
                            msg: "L'équipe a été créée avec succès",
                            state: ToastStates.success,
                          );
                          EquipeCubit.get(context)
                              .getMyEquipe(cursor: "")
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeJoueur(),
                              ),
                              (route) => false,
                            );
                          });
                        } else if (state is CreerEquipeStateBad) {
                          showToast(
                            msg: "Erreur du serveur",
                            state: ToastStates.error,
                          );
                        } else if (state is ErrorState) {
                          String errorMessage = state.errorModel.message!;
                          showToast(
                            msg: errorMessage,
                            state: ToastStates.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return defaultSubmit2(
                          text: 'Créer l\'équipe',
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              EquipeCubit.get(context).creerEquipe(
                                nom: _typeController.text,
                                numero_joueurs: _numberController.text,
                                wilaya: wilayaController.text,
                                commune: dairaController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
