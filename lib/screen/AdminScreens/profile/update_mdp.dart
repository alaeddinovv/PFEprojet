import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';

class UpdateMdpForm extends StatelessWidget {
  UpdateMdpForm({super.key});
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _new1Controller = TextEditingController();
  final TextEditingController _new2Controller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
      listener: (context, state) {
        if (state is UpdateMdpAdminStateGood) {
          showToast(
              msg: "mot de passe modifier avec succes",
              state: ToastStates.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileAdmin()),
            (route) => false,
          );
        } else if (state is UpdateMdpAdminStateBad) {
          showToast(msg: "server crashed", state: ToastStates.error);
        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("modifier Mot de passe"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(children: [
                  if (state is UpdateMdpAdminLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultForm3(
                    context: context,
                    textInputAction: TextInputAction.done,
                    controller: _oldController,
                    type: TextInputType.visiblePassword,
                    onFieldSubmitted: () {},
                    obscureText:
                        ProfileAdminCubit.get(context).isHidden['pass']!,
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
                        ProfileAdminCubit.get(context)
                            .togglePasswordVisibility('pass');
                      },
                      icon: Icon(
                        ProfileAdminCubit.get(context).isHidden['pass']!
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm3(
                    context: context,
                    textInputAction: TextInputAction.done,
                    controller: _new1Controller,
                    type: TextInputType.visiblePassword,
                    onFieldSubmitted: () {},
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'mot_de_passe Must Be Not Empty';
                      }
                      if (value != _new2Controller.text) {
                        return 'mot de passe pas symetrique';
                      }
                    },
                    obscureText:
                        ProfileAdminCubit.get(context).isHidden['pass1']!,
                    labelText: 'nouveau mot de passe',
                    prefixIcon: const Icon(
                      Icons.password_outlined,
                      color: Colors.grey,
                    ),
                    sufixIcon: IconButton(
                      onPressed: () {
                        ProfileAdminCubit.get(context)
                            .togglePasswordVisibility('pass1');
                      },
                      icon: Icon(
                        ProfileAdminCubit.get(context).isHidden['pass1']!
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm3(
                    context: context,
                    textInputAction: TextInputAction.done,
                    controller: _new2Controller,
                    type: TextInputType.visiblePassword,
                    onFieldSubmitted: () {},
                    obscureText:
                        ProfileAdminCubit.get(context).isHidden['pass2']!,
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
                        ProfileAdminCubit.get(context)
                            .togglePasswordVisibility('pass2');
                      },
                      icon: Icon(
                        ProfileAdminCubit.get(context).isHidden['pass2']!
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultSubmit2(
                        text: 'Update',
                        background: Colors.blueAccent,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ProfileAdminCubit.get(context).updateMdpAdmin(
                              old: _oldController.text,
                              newPassword: _new1Controller.text,
                            );
                          }
                        }),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}