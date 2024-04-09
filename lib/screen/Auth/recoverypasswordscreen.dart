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
    // Use MediaQuery to get screen size and set padding and spacing dynamically
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          showToast(msg: "email exist", state: ToastStates.success);
          navigatAndReturn(
            context: context,
            page: VerificationCodeEntryScreen(email: _emailController.text),
          );
        } else if (state is PasswordRecoveryFailure) {
          showToast(msg: "email doesn't exist", state: ToastStates.error);
        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              // Adjust the container height dynamically based on the screen size
              height: screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB0EFE9)],
                ),
              ),
              padding: EdgeInsets.only(top: screenHeight * 0.1, right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/eemail.png',
                    // Adjust image size dynamically based on the screen width
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.23,
                    alignment: Alignment.center,
                  ),
                  const Text(
                    'Forgot password?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                  const Text(
                    'Don’t worry happens to the best of us.\nType your email to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Dynamic spacing
                  Form(
                    key: formKey,
                    child: defaultForm3(
                      context: context,
                      controller: _emailController,
                      type: TextInputType.text,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                        return null; // Ensure validation passes correctly
                      },
                      prefixIcon: const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.grey,
                      ),
                      labelText: "E-mail",
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Dynamic spacing
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Dynamic padding
                    child: defaultSubmit2(
                      text: 'send',
                      background: const Color(0xFF199A8E),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).recoverPassword(
                            email: _emailController.text,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // Dynamic spacing
                  if (state is PasswordRecoveryLoading) const LinearProgressIndicator(),
                  SizedBox(height: screenHeight * 0.01), // Dynamic spacing
                  const Text(
                    'Remember your password?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Dynamic spacing
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
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
