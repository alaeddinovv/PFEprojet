import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';
class UpdateMdpForm extends StatefulWidget {
  const UpdateMdpForm({super.key});
  @override
  State<UpdateMdpForm> createState() => _UpdateMdpFormState();
}

class _UpdateMdpFormState extends State<UpdateMdpForm> {
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _new1Controller = TextEditingController();
  final TextEditingController _new2Controller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  // late final DataAdminModel homeAdminCubit;
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
      listener: (context, state) {
        if (state is UpdateMdpAdminStateGood) {
          showToast(msg: "mot de passe modifier avec succes", state: ToastStates.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileAdmin()),
                (route) => false,
          );
        } else if( state is NewPasswordWrong){
          showToast(msg: "mot de passe pas symetrique", state: ToastStates.warning);

        } else if( state is UpdateMdpAdminStateBad){
          showToast(msg: "server crashed", state: ToastStates.error);

        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message ?? "error";
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
                BlocBuilder<ProfileAdminCubit,ProfileAdminState>(
                  builder: (context, state) {
                  return defaultForm3(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: _oldController,
                      type: TextInputType.visiblePassword,
                      onFieldSubmitted: () {},
                      obscureText: ProfileAdminCubit.get(context).ishidden,
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
                          ProfileAdminCubit.get(context).showpass();
                        },
                        icon: ProfileAdminCubit.get(context).iconhidden,
                        color: Colors.grey,
                      ));
                  },
                ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ProfileAdminCubit,ProfileAdminState>(
                  builder: (context, state) {
                    return defaultForm3(
                        context: context,
                        textInputAction: TextInputAction.done,
                        controller: _new1Controller,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {},
                        obscureText: ProfileAdminCubit.get(context).ishidden1,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'mot_de_passe Must Be Not Empty';
                          }
                        },
                        labelText: 'nouveau mot de passe',
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.grey,
                        ),
                        sufixIcon: IconButton(
                          onPressed: () {
                            ProfileAdminCubit.get(context).showpass1();
                          },
                          icon: ProfileAdminCubit.get(context).iconhidden1,
                          color: Colors.grey,
                        ));
                  },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ProfileAdminCubit,ProfileAdminState>(
                  builder: (context, state) {
                     return defaultForm3(
                        context: context,
                        textInputAction: TextInputAction.done,
                        controller: _new2Controller,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {},
                        obscureText: ProfileAdminCubit.get(context).ishidden2,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'mot_de_passe Must Be Not Empty';
                          }
                        },
                        labelText: 'nouveau mot de passe',
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.grey,
                        ),
                        sufixIcon: IconButton(
                          onPressed: () {
                            ProfileAdminCubit.get(context).showpass2();
                          },
                          icon: ProfileAdminCubit.get(context).iconhidden2,
                          color: Colors.grey,
                        ));
                  },
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
                          if (formkey.currentState!.validate()  ) {
                              ProfileAdminCubit.get(context).updateMdpAdmin(
                                old: _oldController.text,
                                new1: _new1Controller.text,
                                new2 : _new2Controller.text,
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


