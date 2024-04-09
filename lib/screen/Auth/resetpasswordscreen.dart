import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import '../../component/components.dart';
import 'cubit/auth_cubit.dart';

class PasswordResetScreen extends StatelessWidget {
  final String email;
  final String codeentered;

  PasswordResetScreen({super.key, required this.email, required this.codeentered});
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          showToast(msg: "Password updated successfully", state: ToastStates.success);
          navigatAndFinish(context: context, page: Login());
        } else if (state is PasswordResetFailure) {
          showToast(msg: "Email doesn't exist", state: ToastStates.error);
        } else if (state is ErrorState) {
          String errorMessage = state.errorModel.message!;
          showToast(msg: errorMessage, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB0EFE9)],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.14),
                  Text(
                    'Password Reset',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/lock.jpg',
                    width: screenWidth * 0.66,
                    height: screenHeight * 0.25,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                    child: Text(
                      'Now you can enter your new password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultForm3(
                          context: context,
                          controller: _password1Controller,
                          type: TextInputType.visiblePassword,
                          obscureText: AuthCubit.get(context).isHidden['pass']!,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                            if (value != _password2Controller.text) {
                              return 'Passwords do not match';
                            }
                            return null; // Ensure validation logic is correct
                          },
                          labelText: 'New password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          sufixIcon: IconButton(
                            onPressed: () {
                              AuthCubit.get(context).togglePasswordVisibility('pass');
                            },
                            icon: Icon(
                              AuthCubit.get(context).isHidden['pass']!
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        defaultForm3(
                          context: context,
                          controller: _password2Controller,
                          type: TextInputType.visiblePassword,
                          obscureText: AuthCubit.get(context).isHidden['pass1']!,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                            if (value != _password1Controller.text) {
                              return 'Passwords do not match';
                            }
                            return null; // Ensure validation logic is correct
                          },
                          labelText: 'Confirm new password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          sufixIcon: IconButton(
                            onPressed: () {
                              AuthCubit.get(context).togglePasswordVisibility('pass1');
                            },
                            icon: Icon(
                              AuthCubit.get(context).isHidden['pass1']!
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: defaultSubmit2(
                      text: 'Reset Password',
                      background: Color(0xFF199A8E),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).resetPassword(
                            email: email,
                            mdp: _password1Controller.text,
                            codeVerification: codeentered,
                          );
                        }
                      },
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
