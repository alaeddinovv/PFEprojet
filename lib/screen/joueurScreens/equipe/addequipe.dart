import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'cubit/equipe_cubit.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';// Import your JSON data

class AddEquipe extends StatefulWidget {
  AddEquipe({Key? key}) : super(key: key);

  @override
  _AddEquipeState createState() => _AddEquipeState();
}

class _AddEquipeState extends State<AddEquipe> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? selectedWilaya;
  // String? selectedCommune;
  List<dynamic> wilayas = [];
  // List<String> communes = [];

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

  // void updateCommunes(String? wilayaName) {
  //   setState(() {
  //     selectedCommune = null;  // Reset the commune selection
  //     communes = wilayaName != null
  //         ? List<String>.from(wilayas.firstWhere((element) => element['name'] == wilayaName)['communes'])
  //         : [];
  //   });
  // }

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
          title: const Text("Creer une Equipe"),
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
                        return 'Type Must Not Be Empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    labelText: "nom de l'equipe",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                      context: context,
                      controller: _numberController,
                      type: TextInputType.number,
                      labelText: "nombre de joueur",
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'number Must Not Be Empty';
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.format_list_numbered_rounded,
                      ),
                      textInputAction: TextInputAction.next),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Wilaya',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedWilaya,
                    onChanged: (newValue) {
                      setState(() {
                        selectedWilaya = newValue;
                        // updateCommunes(newValue);
                      });
                    },
                    items: wilayas.map((dynamic wilaya) {
                      return DropdownMenuItem<String>(
                        value: wilaya['name'],
                        child: Text(wilaya['name']),
                      );
                    }).toList(),
                  ),
                  // const SizedBox(height: 20),
                  // DropdownButtonFormField<String>(
                  //   decoration: InputDecoration(
                  //     labelText: 'Select Commune',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   value: selectedCommune,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       selectedCommune = newValue;
                  //     });
                  //   },
                  //   items: communes.map((String commune) {
                  //     return DropdownMenuItem<String>(
                  //       value: commune,
                  //       child: Text(commune),
                  //     );
                  //   }).toList(),
                  // ),
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
                              msg: "equipe creer avec succes",
                              state: ToastStates.success);
                          EquipeCubit.get(context)
                              .getMyEquipe(cursor: "")
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeJoueur()),
                                  (route) => false,
                            );
                          });
                        } else if (state is CreerEquipeStateBad) {
                          showToast(
                              msg: "server crashed", state: ToastStates.error);
                        } else if (state is ErrorState) {
                          String errorMessage = state.errorModel.message!;
                          showToast(
                              msg: errorMessage, state: ToastStates.error);
                        }
                      },
                      builder: (context, state) {
                        return defaultSubmit2(
                          text: 'creer l\'equipe',
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              EquipeCubit.get(context).creerEquipe(
                                  nom: _typeController.text,
                                  numero_joueurs: _numberController.text,
                                  wilaya: selectedWilaya
                                  // commune: selectedCommune
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
