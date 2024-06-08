import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
  String enteredCode = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoverySuccess) {
          if (state.isresnd == true) {
            showToast(
                msg: "Code renvoyé avec succès", state: ToastStates.success);
          }
        } else if (state is PasswordRecoveryFailure) {
          showToast(
              msg: "Veuillez redemander le code", state: ToastStates.error);
        } else if (state is VerifyCodeSuccess) {
          showToast(
              msg: "Code vérifié avec succès", state: ToastStates.success);
          navigatAndFinish(
              context: context,
              page: PasswordResetScreen(
                  email: widget.email, codeentered: enteredCode));
        } else if (state is VerifyCodeFailure) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.12),
                const Text(
                  'Vérification',
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
                  'Un code de vérification a été envoyé à ${widget.email}. Veuillez entrer le code ci-dessous :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenWidth * 0.04,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 5,
                    onChanged: (value) {
                      setState(() {
                        enteredCode = value;
                      });
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(0),
                      fieldHeight: screenHeight * 0.1,
                      fieldWidth: screenWidth * 0.16,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: defaultSubmit2(
                    text: 'Envoyer',
                    background: const Color(0xFF199A8E),
                    onPressed: () {
                      AuthCubit.get(context).verifycode(
                          email: widget.email, codeVerification: enteredCode);
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  'Vous n\'avez pas reçu de code ?',
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
                      AuthCubit.get(context)
                          .recoverPassword(email: widget.email, isresend: true);
                    },
                    child: const Text(
                      'Renvoyer le code',
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
        );
      },
    );
  }
}
