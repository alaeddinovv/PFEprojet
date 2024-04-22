import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';
import 'package:pfeprojet/Model/annonce_admin_model.dart';
import 'package:pfeprojet/component/components.dart';

import 'dart:convert';

import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';

class EditAnnoncePage extends StatefulWidget {
  final AnnonceAdminData
  annonceModel; // Assuming AnnonceModel is your data model

  const EditAnnoncePage({Key? key, required this.annonceModel})
      : super(key: key);

  @override
  _EditAnnoncePageState createState() => _EditAnnoncePageState();
}

class _EditAnnoncePageState extends State<EditAnnoncePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? selectedWilaya;
  String? selectedCommune;
  List<dynamic> wilayas = [];
  List<String> communes = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.annonceModel.type);
    _descriptionController = TextEditingController(text: widget.annonceModel.description);
    loadWilayas(); // This needs to complete before setting selectedWilaya and selectedCommune
  }

  void loadWilayas() {
    final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
      selectedWilaya = widget.annonceModel.wilaya ?? (wilayas.isNotEmpty ? wilayas[0]['name'] : null);
      updateCommunes(selectedWilaya);
    });
  }
  void updateCommunes(String? wilayaName) {
    setState(() {
      communes = wilayaName != null
          ? List<String>.from(wilayas.firstWhere((element) => element['name'] == wilayaName)['communes'])
          : [];
      if (!communes.contains(selectedCommune)) {
        selectedCommune = communes.isNotEmpty ? communes[0] : null;
      }
    });
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
          title: const Text('Edit Annonce'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // padding: const EdgeInsets.all(16),
                children: <Widget>[
                  BlocBuilder<AnnonceJoueurCubit, AnnonceJoueurState>(
                    builder: (context, state) {
                      if (state is UpdateAnnonceJoueurLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox(height: 30);
                    },
                  ),
                  defaultForm3(
                    context: context,
                    controller: _titleController,
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
                    labelText: "TYPE DE L'ANNONCE",
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _descriptionController,
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
                    labelText: "contenu de l'annonce",
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
                        updateCommunes(newValue);
                      });
                    },
                    items: wilayas.map<DropdownMenuItem<String>>((dynamic wilaya) {
                      return DropdownMenuItem<String>(
                        value: wilaya['name'],
                        child: Text(wilaya['name']),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Commune',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCommune,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCommune = newValue;
                      });
                    },
                    items: communes.map<DropdownMenuItem<String>>((String commune) {
                      return DropdownMenuItem<String>(
                        value: commune,
                        child: Text(commune),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  // Add more fields if necessary

                  BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
                    listener: (context, state) {
                      if (state is UpdateAnnonceJoueurLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateAnnonceJoueurStateGood) {
                        // Handle success
                        showToast(msg: "Succes", state: ToastStates.success);
                        AnnonceJoueurCubit.get(context)
                            .getMyAnnonceJoueur(cursor: "")
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else if (state is UpdateAnnonceJoueurStateBad) {
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
                                  AnnonceJoueurCubit.get(context).updateAnnonceJoueur(
                                      id: widget.annonceModel.id!,
                                      type: _titleController.text,
                                      description: _descriptionController.text,
                                      wilaya: selectedWilaya,
                                      commune: selectedCommune
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
