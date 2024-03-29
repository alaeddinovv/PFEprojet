import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 // Import your AuthCubit
// import 'PasswordResetScreen.dart';
import '../../component/components.dart';

import 'package:pfeprojet/screen/Auth/resetpasswordscreen.dart';
import 'cubit/auth_cubit.dart'; // Import the password reset screen

class VerificationCodeEntryScreen extends StatefulWidget {
  final String email;

  VerificationCodeEntryScreen({
    required this.email,
  });

  @override
  _VerificationCodeEntryScreenState createState() =>
      _VerificationCodeEntryScreenState();
}

class _VerificationCodeEntryScreenState extends State<VerificationCodeEntryScreen> {
  List<TextEditingController> codeControllers =
  List.generate(5, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  // bool isResendingCode = false; // Track whether code is being resent

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeControllers.length; i++) {
      codeControllers[i].addListener(() {
        if (codeControllers[i].text.length == 1 && i < codeControllers.length - 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    codeControllers.forEach((controller) {
      controller.dispose();
    });
    focusNodes.forEach((focusNode) {
      focusNode.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          showToast(
              msg: "code resended", state: ToastStates.success);
        } else if (state is PasswordRecoveryFailure) {
          showToast(
              msg: "pls ask for code again", state: ToastStates.error);
        }
        // Add more states handling as per your logic
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB0EFE9)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/mail.png',
                    width: 200,
                    height: 100,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 45),
                  Text(
                    'A verification code has been sent to ${widget.email}. Please enter the code below:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return SizedBox(
                          width: 50,
                          height: 70,
                          child: TextField(
                            controller: codeControllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.zero,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < codeControllers.length - 1) {
                                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                              }
                            },
                            maxLength: 1,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultSubmit2(
                      text: 'send',
                      background:  Color(0xFF199A8E),
                      onPressed: () {

                        String enteredCode = codeControllers
                            .map((controller) => controller.text)
                            .join();
                        if (enteredCode == AuthCubit.get(context).recoverPasswordModel!.verificationCode) {
                          navigatAndReturn(
                            context: context,
                            page: PasswordResetScreen(email: widget.email),
                          );
                        } else {
                          showToast(
                              msg: "code non valider", state: ToastStates.success);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Did you fail to receive any code?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                      AuthCubit.get(context).recoverPassword(email: widget.email);
                      },
                      child: Text(
                        'Resend code',
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
                  if (state is PasswordRecoveryLoading)
                    const LinearProgressIndicator(),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
