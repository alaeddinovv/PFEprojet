import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/annonce.dart';

import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';


import 'cubit/annonce_cubit.dart';
class AddAnnonce extends StatefulWidget {
  const AddAnnonce({super.key});
  @override
  State<AddAnnonce> createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  // final TextEditingController _new2Controller = TextEditingController();

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
    return BlocConsumer<AnnonceCubit, AnnonceState>(
      listener: (context, state) {
        if (state is CreerAnnonceStateGood) {
          showToast(msg: "annonce publier avec succes", state: ToastStates.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Annonce()),
                (route) => false,
          );
        }  else if( state is CreerAnnonceStateBad){
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
                  if (state is CreerAnnonceLoadingState)
                    const LinearProgressIndicator(),

                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<AnnonceCubit,AnnonceState>(
                    builder: (context, state) {
                      return defaultForm3(
                        context: context,
                        controller: _typeController,
                        type: TextInputType.emailAddress,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Email Must Not Be Empty';
                          }
                        },
                        prefixIcon: const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.grey,
                        ),
                        labelText: "TYPE DE L'ANNONCE",
                        textInputAction: TextInputAction.next,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AnnonceCubit,AnnonceState>(
                    builder: (context, state) {
                      return BigTextFormField(
                        controller: _textController,
                        type: TextInputType.text, // Adjust as needed
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Text must not be empty'; // Adjust validation message as needed
                          }
                          return null;
                        },
                        labelText: "contenu de l'annonce", // Adjust label text as needed
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.grey,
                        ),
                        // Add other properties as needed, for example, maxLines for a big text form field
                        maxLines: 3, // Example for a big text input field
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultSubmit2(
                        text: 'publier l\'annonce',
                        background: Colors.blueAccent,
                        onPressed: () {
                          if (formkey.currentState!.validate()  ) {
                            AnnonceCubit.get(context).creerAnnonce(
                              type: _typeController.text,
                              text: _textController.text,
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




class BigTextFormField extends StatelessWidget {
  final String? initialValue;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? suffixText;
  final String? labelText;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? type;
  final bool obscureText;

  const BigTextFormField({
    Key? key,
    this.initialValue,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
    this.labelText,
    this.controller,
    this.maxLines,
    this.type,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: textInputAction,
      onFieldSubmitted: (value) => onFieldSubmitted?.call(),
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffix,
        suffixText: suffixText,
        labelText: labelText,
      ),
      controller: controller,
      maxLines: maxLines ?? 1, // Default to 1 if not provided
      keyboardType: type,
      obscureText: obscureText,
    );
  }
}


