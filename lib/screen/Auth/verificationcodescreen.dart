import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/components.dart';
import 'package:pfeprojet/screen/Auth/resetpasswordscreen.dart';
import 'cubit/auth_cubit.dart';

class VerificationCodeEntryScreen extends StatefulWidget {
  final String email;

  VerificationCodeEntryScreen({required this.email});

  @override
  _VerificationCodeEntryScreenState createState() =>
      _VerificationCodeEntryScreenState();
}

class _VerificationCodeEntryScreenState
    extends State<VerificationCodeEntryScreen> {
  List<TextEditingController> codeControllers =
  List.generate(5, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());
  String enteredCode = '';

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeControllers.length; i++) {
      codeControllers[i].addListener(() {
        if (codeControllers[i].text.length == 1 &&
            i < codeControllers.length - 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          // Handle success
        } else if (state is PasswordRecoveryFailure) {
          showToast(msg: "Please ask for the code again", state: ToastStates.error);
        } else if (state is VerifyCodeSuccess) {
          showToast(msg: "Code verified successfully", state: ToastStates.success);
          navigatAndFinish(context: context, page: PasswordResetScreen(email: widget.email, codeentered: enteredCode));
        } else if (state is VerifyCodeFailure) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
        // Handle more states as per your logic
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB0EFE9)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.12),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Image.asset(
                    'assets/images/mail.png',
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.14,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'A verification code has been sent to ${widget.email}. Please enter the code below:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.04, // dynamically sized text
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return SizedBox(
                          width: screenWidth * 0.15, // dynamic width
                          height: screenHeight * 0.1, // dynamic height
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
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: defaultSubmit2(
                      text: 'send',
                      background: const Color(0xFF199A8E),
                      onPressed: () {
                        enteredCode = codeControllers.map((controller) => controller.text).join();
                        AuthCubit.get(context).verifycode(email: widget.email, codeVerification: enteredCode);
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    'Did you fail to receive any code?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        AuthCubit.get(context).recoverPassword(email: widget.email);
                      },
                      child: const Text(
                        'Resend code',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF199A8E),
                        ),
                      ),
                    ),
                  ),
                  if (state is PasswordRecoveryLoading) const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
