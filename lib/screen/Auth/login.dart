import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/Auth/register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                  defaultForm(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: passController,
                      type: TextInputType.visiblePassword,
                      onFieldSubmitted: () {},
                      obscureText: true,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'Password Must Be Not Empty';
                        }
                      },
                      lable: const Text(
                        "Password",
                        style: TextStyle(color: Colors.grey),
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
                      sufixIcon: IconButton(
                        onPressed: () {
                          // LoginCubit.get(context).showpass();
                        },
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    height: 18,
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
                                context: context, page: Register());
                          },
                          child: const Text("Register now"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
