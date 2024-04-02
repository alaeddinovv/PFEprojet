import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/Auth/verificationcodescreen.dart';

import 'cubit/auth_cubit.dart';
import 'login.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  PasswordRecoveryScreen({super.key});
  final TextEditingController _emailController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          showToast(msg: "email exist", state: ToastStates.success);

          navigatAndReturn(
            context: context,
            page: VerificationCodeEntryScreen(email: _emailController.text),
          );
        } else if (state is PasswordRecoveryFailure) {
          showToast(msg: "email doesnt exist", state: ToastStates.error);
        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: 759,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB0EFE9)],
                ),
              ),
              padding: EdgeInsets.only(top: 90.0, right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/eemail.png',
                    width: 220,
                    height: 165,
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Don’t worry happens to the best of us.\nType your email to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: formkey,
                    child: defaultForm3(
                      context: context,
                      controller: _emailController,
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
                      labelText: "E-mail",
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultSubmit2(
                      text: 'send',
                      background: Color(0xFF199A8E),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          AuthCubit.get(context).recoverPassword(
                            email: _emailController.text,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  if (state is PasswordRecoveryLoading)
                    const LinearProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Remember your password?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log in',
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
          ),
        );
      },
    );
  }
}
