import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_form.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_mdp.dart';

import '../../../Model/user_model.dart';


import '../home/home.dart';

class ProfileJoueur extends StatelessWidget {
  const ProfileJoueur({super.key});

  @override
  Widget build(BuildContext context) {
    final DataJoueurModel joueurModel = HomeJoueurCubit.get(context).joueurModel!;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatAndFinish(context: context, page: const HomeJoueur());
            },
          ),
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
        body: BlocConsumer<ProfileJoueurCubit, ProfileJoueurState>(
          listener: (context, state) {},
          builder: (context, state) {
            // if (state is GetMyInformationLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (!didPop) {
                  navigatAndFinish(context: context, page: const HomeJoueur());
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: joueurModel.photo != null
                          ? NetworkImage(joueurModel.photo!)
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
                        joueurModel.nom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Prenom'),
                      subtitle: Text(
                        joueurModel.prenom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: const Text('Wilaya'),
                      subtitle: Text(
                        joueurModel.wilaya!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(
                        joueurModel.email!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone'),
                      subtitle: Text(
                        joueurModel.telephone!.toString(),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              color: Colors.blueAccent,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    // textStyle: const TextStyle(fontSize: 19),
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () {
                                  navigatAndReturn(
                                    context: context,
                                    page: const UpdateJoueurForm(),
                                  );
                                },
                                child: const Text(
                                  "Modifier profile",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 55,
                              color: Colors.blueAccent,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    // textStyle: const TextStyle(fontSize: 19),
                                    backgroundColor: Colors.blueAccent),
                                onPressed: () {
                                  navigatAndReturn(
                                    context: context,
                                    page: UpdateMdpForm(),
                                  );
                                },
                                child: const Text(
                                  "Modifier mdp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
