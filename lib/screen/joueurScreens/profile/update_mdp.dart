import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';

class UpdateMdpForm extends StatelessWidget {
  UpdateMdpForm({super.key});
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _new1Controller = TextEditingController();
  final TextEditingController _new2Controller = TextEditingController();

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
          title: const Text("modifier Mot de passe"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(children: [
                BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                  builder: (context, state) {
                    if (state is UpdateMdpJoueurLoadingState) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                  builder: (context, state) {
                    return defaultForm3(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: _oldController,
                      type: TextInputType.visiblePassword,
                      obscureText:
                          ProfileJoueurCubit.get(context).isHidden['pass']!,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'mot_de_passe Must Be Not Empty';
                        }
                      },
                      labelText: 'encient mot de passe',
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: Colors.grey,
                      ),
                      sufixIcon: IconButton(
                        onPressed: () {
                          ProfileJoueurCubit.get(context)
                              .togglePasswordVisibility('pass');
                        },
                        icon: Icon(
                          ProfileJoueurCubit.get(context).isHidden['pass']!
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                  builder: (context, state) {
                    return defaultForm3(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: _new1Controller,
                      type: TextInputType.visiblePassword,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'mot_de_passe Must Be Not Empty';
                        }
                        if (value != _new2Controller.text) {
                          return 'mot de passe pas symetrique';
                        }
                      },
                      obscureText:
                          ProfileJoueurCubit.get(context).isHidden['pass1']!,
                      labelText: 'nouveau mot de passe',
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: Colors.grey,
                      ),
                      sufixIcon: IconButton(
                        onPressed: () {
                          ProfileJoueurCubit.get(context)
                              .togglePasswordVisibility('pass1');
                        },
                        icon: Icon(
                          ProfileJoueurCubit.get(context).isHidden['pass1']!
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                  builder: (context, state) {
                    return defaultForm3(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: _new2Controller,
                      type: TextInputType.visiblePassword,
                      obscureText:
                          ProfileJoueurCubit.get(context).isHidden['pass2']!,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'mot_de_passe Must Be Not Empty';
                        }
                        if (value != _new1Controller.text) {
                          return 'mot de passe pas symetrique';
                        }
                      },
                      labelText: 'nouveau mot de passe',
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: Colors.grey,
                      ),
                      sufixIcon: IconButton(
                        onPressed: () {
                          ProfileJoueurCubit.get(context)
                              .togglePasswordVisibility('pass2');
                        },
                        icon: Icon(
                          ProfileJoueurCubit.get(context).isHidden['pass2']!
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<ProfileJoueurCubit, ProfileJoueurState>(
                    listener: (context, state) {
                      if (state is UpdateMdpJoueurLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateMdpJoueurStateGood) {
                        showToast(
                            msg: "mot de passe modifier avec succes",
                            state: ToastStates.success);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileJoueur()),
                          (route) => false,
                        );
                      } else if (state is UpdateMdpJoueurStateBad) {
                        showToast(
                            msg: "server crashed", state: ToastStates.error);
                      } else if (state is ErrorState) {
                        String errorMessage = state.errorModel.message!;
                        showToast(msg: errorMessage, state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return defaultSubmit2(
                          text: 'Update',
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              ProfileJoueurCubit.get(context).updateMdpJoueur(
                                old: _oldController.text,
                                newPassword: _new1Controller.text,
                              );
                            }
                          });
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
