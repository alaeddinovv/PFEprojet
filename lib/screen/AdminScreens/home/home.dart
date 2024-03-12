import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeAdmin'),
        actions: [
          BlocBuilder<HomeAdminCubit, HomeAdminState>(
            builder: (context, state) {
              if (state is GetMyInformationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return InkWell(
                onTap: () {
                  navigatAndReturn(
                      context: context, page: const ProfileAdmin());
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      HomeAdminCubit.get(context).adminModel!.photo != null
                          ? NetworkImage(
                              HomeAdminCubit.get(context).adminModel!.photo!)
                          : const AssetImage('assets/images/user.png')
                              as ImageProvider<Object>,
                ),
              );
            },
          ),

          // TextButton(
          //     onPressed: () {
          //       CachHelper.removdata(key: "TOKEN");
          //       navigatAndFinish(context: context, page: Login());
          //     },
          //     child: const Text(
          //       "disconnect",
          //       style: TextStyle(color: Colors.red),
          //     ))
        ],
      ),
      body: const Text("hi"),
    );
  }
}
