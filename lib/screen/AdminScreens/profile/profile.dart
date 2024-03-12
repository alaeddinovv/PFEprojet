import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/update_form.dart';
import 'package:pfeprojet/screen/Auth/login.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final DataAdminModel adminModel = HomeAdminCubit.get(context).adminModel!;

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     navigatAndFinish(context: context, page: const HomeAdmin());
          //   },
          // ),
          title: const Text('Profile'),
          actions: [
            TextButton(
                onPressed: () {
                  navigatAndFinish(context: context, page: Login());
                  CachHelper.removdata(key: "TOKEN");
                  showToast(msg: "Disconnect", state: ToastStates.error);
                },
                child: const Text(
                  "Disconnect",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
        body: BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            // if (state is GetMyInformationLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: adminModel.photo != null
                        ? NetworkImage(adminModel.photo!)
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider<Object>,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Nom'),
                    subtitle: Text(
                      adminModel.nom!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Prenom'),
                    subtitle: Text(
                      adminModel.prenom!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: const Text('Wilaya'),
                    subtitle: Text(
                      adminModel.wilaya!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(
                      adminModel.email!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(adminModel.telephone!.toString()),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigatAndReturn(
                          context: context, page: UpdateAdminForm());
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
