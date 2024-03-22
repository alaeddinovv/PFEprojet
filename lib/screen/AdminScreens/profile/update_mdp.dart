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
                  defaultForm2(
                      controller: _oldController,
                      textInputAction: TextInputAction.next,
                      label: 'old pasword',
                      prefixIcon: const Icon(Icons.password_outlined),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Must Be Not Empty";
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm2(
                      controller: _new1Controller,
                      textInputAction: TextInputAction.next,
                      label: 'new password',
                      prefixIcon: const Icon(
                        Icons.password_outlined,

                      ),
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Must Be Not Empty";
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm2(
                      controller: _new2Controller,
                      textInputAction: TextInputAction.next,
                      label: 'new password again',
                      prefixIcon: const Icon(Icons.password_outlined),
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Must Be Not Empty";
                        }
                      }),

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


