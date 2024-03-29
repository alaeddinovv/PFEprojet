import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';

import 'cubit/annonce_cubit.dart';

class AddAnnonce extends StatelessWidget {
  AddAnnonce({super.key});
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final formkey = GlobalKey<FormState>();
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
          title: const Text("Ajouter une annonce"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<AnnonceCubit, AnnonceState>(
                    builder: (context, state) {
                      if (state is CreerAnnonceLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 30,
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
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<AnnonceCubit, AnnonceState>(
                      listener: (context, state) {
                        if (state is CreerAnnonceLoadingState) {
                          canPop = false;
                        } else {
                          canPop = true;
                        }
                        if (state is CreerAnnonceStateGood) {
                          showToast(
                              msg: "annonce publier avec succes",
                              state: ToastStates.success);
                          AnnonceCubit.get(context)
                              .getMyAnnonce()
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeAdmin()),
                              (route) => false,
                            );
                          });
                        } else if (state is CreerAnnonceStateBad) {
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
                              AnnonceCubit.get(context).creerAnnonce(
                                type: _typeController.text,
                                text: _textController.text,
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
