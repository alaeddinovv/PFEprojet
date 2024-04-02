import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import '../../component/components.dart';
import 'cubit/auth_cubit.dart';
// import 'cubit/password_reset_cubit.dart'; // Make sure to import your PasswordResetCubit

class PasswordResetScreen extends StatelessWidget {
  final String email;
  final String codeentered;

  PasswordResetScreen(
      {super.key, required this.email, required this.codeentered});
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          showToast(
              msg: "password updated succecfuly", state: ToastStates.success);

          navigatAndFinish(
            context: context,
            page: Login(),
          );
        } else if (state is PasswordResetFailure) {
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
                    width: 250,
                    height: 200,
                    alignment: Alignment.center,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Now you can enter your new password ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        defaultForm3(
                          context: context,
                          textInputAction: TextInputAction.done,
                          controller: _password1Controller,
                          type: TextInputType.visiblePassword,
                          onFieldSubmitted: () {},
                          obscureText: AuthCubit.get(context).isHidden['pass']!,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'mot_de_passe Must Be Not Empty';
                            }
                            if (value != _password2Controller.text) {
                              return 'mot de passe pas symetrique';
                            }
                          },
                          labelText: 'nouveau mot de passe',
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            color: Colors.grey,
                          ),
                          sufixIcon: IconButton(
                            onPressed: () {
                              AuthCubit.get(context)
                                  .togglePasswordVisibility('pass');
                            },
                            icon: Icon(
                              AuthCubit.get(context).isHidden['pass']!
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        defaultForm3(
                          context: context,
                          textInputAction: TextInputAction.done,
                          controller: _password2Controller,
                          type: TextInputType.visiblePassword,
                          onFieldSubmitted: () {},
                          obscureText:
                              AuthCubit.get(context).isHidden['pass1']!,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'mot_de_passe Must Be Not Empty';
                            }
                            if (value != _password1Controller.text) {
                              return 'mot de passe pas symetrique';
                            }
                          },
                          labelText: 'nouveau mot de passe',
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            color: Colors.grey,
                          ),
                          sufixIcon: IconButton(
                            onPressed: () {
                              AuthCubit.get(context)
                                  .togglePasswordVisibility('pass1');
                            },
                            icon: Icon(
                              AuthCubit.get(context).isHidden['pass1']!
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultSubmit2(
                      text: 'reset password',
                      background: Color(0xFF199A8E),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          AuthCubit.get(context).resetPassword(
                              email: email,
                              mdp: _password1Controller.text,
                              codeVerification: codeentered);
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
