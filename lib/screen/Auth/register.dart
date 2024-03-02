import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/Auth/login.dart';

import '../../component/components.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final numberController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> sendinfologin = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        defaultForm(
                            context: context,
                            controller: nameController,
                            type: TextInputType.text,
                            lable: const Text(
                              'Name',
                              style: TextStyle(color: Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'name Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            textInputAction: TextInputAction.next),
                        const SizedBox(
                          height: 18,
                        ),
                        defaultForm(
                            context: context,
                            controller: prenomController,
                            type: TextInputType.text,
                            lable: const Text(
                              'Prenom',
                              style: TextStyle(color: Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'prenom Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            textInputAction: TextInputAction.next),
                        const SizedBox(
                          height: 18,
                        ),
                        defaultForm(
                            context: context,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            lable: const Text(
                              'Email',
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
                        defaultForm(
                            context: context,
                            controller: ageController,
                            type: TextInputType.number,
                            lable: const Text(
                              'Age',
                              style: TextStyle(color: Colors.grey),
                            ),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Age Must Not Be Empty';
                              }
                            },
                            onFieldSubmitted: () {},
                            prefixIcon: const Icon(
                              Icons.format_list_numbered_rounded,
                              color: Colors.grey,
                            ),
                            textInputAction: TextInputAction.next),
                        const SizedBox(
                          height: 18,
                        ),
                        defaultForm(
                            context: context,
                            textInputAction: TextInputAction.done,
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            onFieldSubmitted: () {},
                            obscureText: AuthCubit.get(context).ishidden,
                            valid: (value) {
                              if (value.isEmpty) {
                                return 'Password Must Be Not Empty';
                              }
                            },
                            lable: const Text(
                              'Password',
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
                            )),
                        const SizedBox(
                          height: 18,
                        ),
                        defaultForm(
                          context: context,
                          controller: numberController,
                          type: TextInputType.number,
                          lable: const Text(
                            'Phone',
                            style: TextStyle(color: Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Phone Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              width: double.infinity,
                              child: MaterialButton(
                                highlightColor: Colors.blue,
                                splashColor: const Color.fromRGBO(0, 0, 0, 0),
                                onPressed: () {
                                  sendinfologin = {
                                    "email": "houssem@gmail.com",
                                    "mot_de_passe": "123456"
                                  };

                                  AuthCubit.get(context).registerUser(
                                      data: sendinfologin, path: Loginjoueur);
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You already have an account',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                                onPressed: () {
                                  changepage(context, Login());
                                },
                                child: const Text('Login'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
