import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';
import 'package:pfeprojet/Model/equipe_model.dart';

import 'package:pfeprojet/component/components.dart';

import 'dart:convert';

import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';

class EditEquipe extends StatefulWidget {
  final EquipeData
  equipeModel; // Assuming AnnonceModel is your data model

  const EditEquipe({Key? key, required this.equipeModel})
      : super(key: key);

  @override
  _EditEquipeState createState() => _EditEquipeState();
}

class _EditEquipeState extends State<EditEquipe> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _numberController;
  String? selectedWilaya;

  List<dynamic> wilayas = [];


  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.equipeModel.nom);
    _numberController = TextEditingController(text: widget.equipeModel.numeroJoueurs.toString());
    loadWilayas(); // This needs to complete before setting selectedWilaya and selectedCommune
  }

  void loadWilayas() {
    final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
      selectedWilaya = widget.equipeModel.wilaya ?? (wilayas.isNotEmpty ? wilayas[0]['name'] : null);
      // updateCommunes(selectedWilaya);
    });
  }
  // void updateCommunes(String? wilayaName) {
  //   setState(() {
  //     communes = wilayaName != null
  //         ? List<String>.from(wilayas.firstWhere((element) => element['name'] == wilayaName)['communes'])
  //         : [];
  //     if (!communes.contains(selectedCommune)) {
  //       selectedCommune = communes.isNotEmpty ? communes[0] : null;
  //     }
  //   });
  // }
  @override
  void dispose() {
    _nomController.dispose();
    _numberController.dispose();
    super.dispose();
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
          title: const Text('Edit Equipe'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // padding: const EdgeInsets.all(16),
                children: <Widget>[
                  BlocBuilder<EquipeCubit, EquipeState>(
                    builder: (context, state) {
                      if (state is UpdateEquipeLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox(height: 30);
                    },
                  ),
                  defaultForm3(
                    context: context,
                    controller: _nomController,
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
                    labelText: "NOM DE L'EQUIPE",
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _numberController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Contenu Must Not Be Empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    maxline: 3,
                    labelText: "nombre de joueur",
                    textInputAction: TextInputAction.done,
                  ),
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
                    items: wilayas.map<DropdownMenuItem<String>>((dynamic wilaya) {
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
                  //   items: communes.map<DropdownMenuItem<String>>((String commune) {
                  //     return DropdownMenuItem<String>(
                  //       value: commune,
                  //       child: Text(commune),
                  //     );
                  //   }).toList(),
                  // ),

                  const SizedBox(height: 20),
                  // Add more fields if necessary

                  BlocConsumer<EquipeCubit, EquipeState>(
                    listener: (context, state) {
                      if (state is UpdateEquipeLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateEquipeStateGood) {
                        // Handle success
                        showToast(msg: "Succes", state: ToastStates.success);
                        EquipeCubit.get(context)
                            .getMyEquipe(cursor: "")
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else if (state is UpdateEquipeStateBad) {
                        // Handle failure
                        showToast(msg: "Failed", state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            defaultSubmit2(
                              text: 'Update',
                              background: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  EquipeCubit.get(context).updateEquipe(
                                      id: widget.equipeModel.id!,
                                      nom: _nomController.text,
                                      numero_joueurs: _numberController.text,
                                      wilaya: selectedWilaya
                                      // commune: selectedCommune
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
