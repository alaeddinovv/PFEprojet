import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/Auth/verificationcodescreen.dart';

import 'cubit/auth_cubit.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  PasswordRecoveryScreen({super.key});
  final TextEditingController _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          if (state.isresnd == false) {
            showToast(msg: "L'email existe", state: ToastStates.success);
            navigatAndReturn(
              context: context,
              page: VerificationCodeEntryScreen(email: _emailController.text),
            );
          }
        } else if (state is PasswordRecoveryFailure) {
          showToast(msg: "L'email n'existe pas", state: ToastStates.error);
        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.15),
                Image.asset(
                  'assets/images/eemail.png',
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.23,
                  alignment: Alignment.center,
                ),
                const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  'Ne vous inquiétez pas, ça arrive aux meilleurs d\'entre nous.\nEntrez votre email pour réinitialiser votre mot de passe.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: defaultForm3(
                      context: context,
                      controller: _emailController,
                      type: TextInputType.text,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Le champ ne doit pas être vide';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.grey,
                      ),
                      labelText: "E-mail",
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: defaultSubmit2(
                    text: 'Envoyer',
                    background: const Color(0xFF199A8E),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthCubit.get(context).recoverPassword(
                          email: _emailController.text,
                          isresend: false,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                if (state is PasswordRecoveryLoading)
                  const LinearProgressIndicator(),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  'Vous vous souvenez de votre mot de passe ?',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Se connecter',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF199A8E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
