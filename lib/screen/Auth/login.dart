import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/Auth/about_us.dart';
import 'package:pfeprojet/screen/Auth/cubit/auth_cubit.dart';
import 'package:pfeprojet/screen/Auth/recoverypasswordscreen.dart';
import 'package:pfeprojet/screen/Auth/register_joueur.dart';
import 'package:pfeprojet/screen/joueurScreens/home/home.dart';
import 'package:pfeprojet/generated/l10n.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    double verticalPadding = screenHeight * 0.02;
    double horizontalPadding = screenWidth * 0.05;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Image.asset(
                  'assets/images/creno.png',
                  width: screenWidth - 100,
                ),
                SizedBox(height: screenHeight * 0.025),
                Text(
                  S.of(context).welcome,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  S.of(context).discover_unlimited_choices,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                )
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  defaultForm3(
                    context: context,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return S.of(context).email_cannot_be_empty;
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    labelText: S.of(context).email,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return defaultForm3(
                          context: context,
                          textInputAction: TextInputAction.done,
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          obscureText: AuthCubit.get(context).ishidden,
                          valid: (value) {
                            if (value.isEmpty) {
                              return S.of(context).password_cannot_be_empty;
                            }
                          },
                          labelText: S.of(context).password,
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
                  SizedBox(height: screenHeight * 0.01),
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
                                    PATH1 = value == true
                                        ? RECOVERPASSWORD
                                        : RECOVERPASSWORDADMIN;
                                    PATH2 = value == true
                                        ? VERIFYJOUEURCODE
                                        : VERIFYADMINCODE;
                                    PATH3 = value == true
                                        ? RESETPASSWORD
                                        : RESETPASSWORDADMIN;
                                  }),
                              TextButton(
                                  child: Text(
                                    S.of(context).responsible,
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
                          onPressed: () {
                            navigatAndReturn(
                              context: context,
                              page: PasswordRecoveryScreen(),
                            );
                          },
                          child: Text(S.of(context).forgot_password))
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (BuildContext context, AuthState state) async {
                      if (state is LoginStateGood) {
                        showToast(
                            msg: S.of(context).hello(state.model.data!.nom!),
                            state: ToastStates.success);
                        TOKEN = state.model.token!;
                        print(TOKEN);
                        CachHelper.putcache(key: "TOKEN", value: TOKEN);
                        if (PATH == Loginadmin) {
                          HomeAdminCubit.get(context)
                              .setAdminModel(state.model.data!);
                          addOrUpdateFCMTokenAdmin(
                                  fcmToken: fCMToken,
                                  device: await CachHelper.getData(
                                      key: 'deviceInfo'))
                              .then((value) {
                            navigatAndFinish(
                                context: context, page: const HomeAdmin());
                          });
                        } else if (PATH == Loginjoueur) {
                          CachHelper.putcache(
                              key: "suggestionId", value: state.suggestionId);
                          addOrUpdateFCMTokenJoueur(
                                  fcmToken: fCMToken,
                                  device: await CachHelper.getData(
                                      key: 'deviceInfo'))
                              .then((value) {
                            navigatAndFinish(
                                context: context, page: const HomeJoueur());
                          });
                        }
                      } else if (state is ErrorState) {
                        showToast(
                            msg: state.errorModel.message!,
                            state: ToastStates.error);
                      } else if (state is LoginStateBad) {
                        showToast(
                            msg: S.of(context).error, state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return defaultSubmit2(
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
                          text: S.of(context).login);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        // textStyle: const TextStyle(fontSize: 19),
                        // backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        navigatAndReturn(
                            context: context, page: RegisterJoueur());
                      },
                      child: Text(
                        S.of(context).create_account,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
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
                InkWell(
                  onTap: () {
                    navigatAndReturn(context: context, page: AboutUsPage());
                  },
                  child: Text(
                    S.of(context).about_us,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
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
            SizedBox(height: screenHeight * 0.015),
          ],
        ),
      ),
    );
  }
}
