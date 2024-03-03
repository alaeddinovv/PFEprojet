import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/home.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/Auth/register_joueur.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ToggleButton(),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    defaultForm(
                        context: context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        lable: const Text(
                          "Email Address",
                          style: TextStyle(color: Colors.grey),
                        ),
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Email Must Not Be Empty';
                          }
                        },
                        onFieldSubmitted: () {},
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        textInputAction: TextInputAction.next),
                    const SizedBox(
                      height: 18,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return defaultForm(
                            context: context,
                            textInputAction: TextInputAction.done,
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            onFieldSubmitted: () {},
                            obscureText: AuthCubit.get(context).ishidden,
                            valid: (value) {
                              if (value.isEmpty) {
                                return 'mot_de_passe Must Be Not Empty';
                              }
                            },
                            lable: const Text(
                              'mot_de_passe',
                              style: TextStyle(color: Colors.grey),
                            ),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            sufixIcon: IconButton(
                              onPressed: () {
                                AuthCubit.get(context).showpass();
                              },
                              icon: AuthCubit.get(context).iconhidden,
                              color: Colors.grey,
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (BuildContext context, AuthState state) {
                        if (state is LoginStateGood) {
                          navigatAndFinish(
                              context: context, page: const Home());
                          showToast(
                              msg: 'Hi ${state.model.data!.nom!}',
                              state: ToastStates.success);
                        } else if (state is ErrorState) {
                          showToast(
                              msg: ' ${state.errorModel.message}',
                              state: ToastStates.error);
                        } else if (state is LoginStateBad) {
                          showToast(msg: "Error", state: ToastStates.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return buttonSubmit(
                            text: 'Register',
                            context: context,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> sendinfologin = {
                                  "email": emailController.text,
                                  'mot_de_passe': passController.text
                                };
                                AuthCubit.get(context).login(
                                  data: sendinfologin,
                                  path: PATH,
                                );
                              }
                            });
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You dont't have an account",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              navigatAndReturn(
                                  context: context, page: RegisterJour());
                            },
                            child: const Text("Register now?"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity, // Makes the ToggleButtons fill the width
        child: Align(
          alignment: Alignment.center,
          child: ToggleButtons(
            isSelected: _selections,
            onPressed: (int index) {
              setState(() {
                // _selections[index] = !_selections[index];
                // _selections[(index + 1) % 2] = !_selections[index];
                if (index == 0) {
                  _selections[index] = true;
                  _selections[index + 1] = false;
                  PATH = Loginjoueur;
                  print(PATH);
                } else if (index == 1) {
                  _selections[index] = true;
                  _selections[index - 1] = false;
                  PATH = Loginadmin;
                  print(PATH);
                }
              });
            },
            color: Colors.blue,
            selectedColor: Colors.white,
            fillColor: Colors.blue,
            borderColor: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
            borderWidth: 4.0,
            selectedBorderColor: Colors.blue,
            children: [
              SizedBox(
                width: 110,
                child: Text(
                  textAlign: TextAlign.center,
                  'Joueur',
                  style: TextStyle(
                    color: _selections[0] ? Colors.white : Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  'Admin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selections[1] ? Colors.white : Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
