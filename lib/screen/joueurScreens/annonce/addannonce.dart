import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';

import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/addAnnonceNew.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart'; // Import your JSON data

class AddAnnonce extends StatefulWidget {
  const AddAnnonce({Key? key}) : super(key: key);

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final wilayaController = TextEditingController();
  final dairaController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigatAndReturn(context: context, page: AddAnnonceScreen());
          },
        ),
        appBar: AppBar(
          title: const Text("Ajouter une annonce"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<AnnonceJoueurCubit, AnnonceJoueurState>(
                    builder: (context, state) {
                      if (state is CreerAnnonceJoueurLoadingState) {
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
                    labelText: "TYPE DE L'ANNONCE",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _textController,
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
                    child: BlocConsumer<AnnonceJoueurCubit, AnnonceJoueurState>(
                      listener: (context, state) {
                        if (state is CreerAnnonceJoueurLoadingState) {
                          canPop = false;
                        } else {
                          canPop = true;
                        }
                        if (state is CreerAnnonceJoueurStateGood) {
                          showToast(
                              msg: "annonce publier avec succes",
                              state: ToastStates.success);
                          AnnonceJoueurCubit.get(context)
                              .getMyAnnonceJoueur(cursor: "")
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeJoueur()),
                              (route) => false,
                            );
                          });
                        } else if (state is CreerAnnonceJoueurStateBad) {
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
                          text: 'publier l\'annonce',
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              AnnonceJoueurCubit.get(context)
                                  .creerAnnonceJoueur(
                                      type: _typeController.text,
                                      text: _textController.text,
                                      wilaya: wilayaController.text,
                                      commune: dairaController.text);
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
