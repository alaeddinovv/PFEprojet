import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/design_register.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';

class LoginDesign extends StatelessWidget {
  LoginDesign({super.key});
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(bottom: 24, left: 24, right: 24, top: 56),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  'Welcome back,',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Discover Limitess Choices and Unmatched Convenience.",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    defaultForm3(
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Email Must Not Be Empty';
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.grey,
                      ),
                      labelText: "E-Mail",
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return defaultForm3(
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
                            labelText: 'mot_de_passe',
                            prefixIcon: const Icon(
                              Icons.password_outlined,
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
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: AuthCubit.get(context).checkBox,
                                    onChanged: (value) {
                                      AuthCubit.get(context).changeCheckBox();
                                      PATH = value == true
                                          ? Loginadmin
                                          : Loginjoueur;
                                    }),
                                TextButton(
                                    child: const Text(
                                      'Responsable',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      AuthCubit.get(context).changeCheckBox();
                                      if (PATH == Loginadmin) {
                                        PATH = Loginjoueur;
                                      } else {
                                        PATH = Loginadmin;
                                      }
                                    })
                              ],
                            );
                          },
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forget Password?"))
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (BuildContext context, AuthState state) async {
                        if (state is LoginStateGood) {
                          if (PATH == Loginadmin) {
                            HomeAdminCubit.get(context)
                                .setAdminModel(state.model.data!);
                            navigatAndFinish(
                                context: context, page: const HomeAdmin());
                          } else if (PATH == Loginjoueur) {
                            navigatAndFinish(
                                context: context, page: const HomeJoueur());
                          }
                          showToast(
                              msg: 'Hi ${state.model.data!.nom!}',
                              state: ToastStates.success);
                          TOKEN = state.model.token!;
                          print(TOKEN);
                          CachHelper.putcache(key: "TOKEN", value: TOKEN);
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
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                // textStyle: const TextStyle(fontSize: 19),
                                backgroundColor: Colors.blueAccent),
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
                            },
                            child: const Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          // textStyle: const TextStyle(fontSize: 19),
                          // backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          navigatAndReturn(
                              context: context, page: RegisterDesign());
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    indent: 60,
                    endIndent: 5,
                  ),
                ),
                Text(
                  "Or Sign In with",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Flexible(
                  child: Divider(
                    color: Colors.grey,
                    height: 3,
                    thickness: 0.5,
                    indent: 5,
                    endIndent: 60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: const Image(
                      width: 24,
                      height: 24,
                      image: AssetImage("assets/images/google.png"),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: const Image(
                      width: 24,
                      height: 24,
                      image: AssetImage("assets/images/facebook.png"),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField formField2() {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
          labelText: "E-Mail"),
    );
  }
}
