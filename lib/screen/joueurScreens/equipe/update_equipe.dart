import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/equipe_model.dart';

import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';

import 'package:pfeprojet/screen/joueurScreens/equipe/cubit/equipe_cubit.dart';

class EditEquipe extends StatefulWidget {
  final EquipeData equipeModel;
  final bool vertial;
  const EditEquipe({Key? key, required this.equipeModel, required this.vertial})
      : super(key: key);

  @override
  _EditEquipeState createState() => _EditEquipeState();
}

class _EditEquipeState extends State<EditEquipe> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _numberController;
  late TextEditingController _wilayaController;
  late TextEditingController _dairaController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.equipeModel.nom);
    _numberController = TextEditingController(
        text: widget.equipeModel.numeroJoueurs.toString());
    _wilayaController = TextEditingController(text: widget.equipeModel.wilaya);
    _dairaController = TextEditingController(text: widget.equipeModel.commune);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _numberController.dispose();
    _wilayaController.dispose();
    _dairaController.dispose();
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
          title: const Text('Modifier l\'équipe'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
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
                        return 'Le nom ne doit pas être vide';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    labelText: "NOM DE L'ÉQUIPE",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _numberController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Le nombre de joueurs ne doit pas être vide';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    maxline: 3,
                    labelText: "Nombre de joueurs",
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  DropdownScreen(
                    selectedDaira: _dairaController,
                    selectedWilaya: _wilayaController,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<EquipeCubit, EquipeState>(
                    listener: (context, state) {
                      if (state is UpdateEquipeLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateEquipeStateGood) {
                        showToast(
                            msg: "Modification effectuée avec succès",
                            state: ToastStates.success);
                        EquipeCubit.get(context)
                            .getMyEquipe(cursor: "", vertial: widget.vertial)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else if (state is UpdateEquipeStateBad) {
                        showToast(
                            msg: "Échec de la modification",
                            state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            defaultSubmit2(
                              text: 'Mettre à jour',
                              background: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  EquipeCubit.get(context).updateEquipe(
                                    id: widget.equipeModel.id,
                                    nom: _nomController.text,
                                    numero_joueurs: _numberController.text,
                                    wilaya: _wilayaController.text,
                                    commune: _dairaController.text,
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
