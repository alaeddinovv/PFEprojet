import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/cubit/main_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:pfeprojet/screen/Auth/login.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_form.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_mdp.dart';
import 'package:flutter/services.dart';

import '../../../Model/user_model.dart';

import '../home/home.dart';

class ProfileJoueur extends StatelessWidget {
  const ProfileJoueur({super.key});

  @override
  Widget build(BuildContext context) {
    final DataJoueurModel joueurModel =
        HomeJoueurCubit.get(context).joueurModel!;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatAndFinish(context: context, page: const HomeJoueur());
            },
          ),
          title: Text(S.of(context).profile),
          actions: [
            TextButton(
                onPressed: () async {
                  removeFCMTokenJoueur(
                          device: await CachHelper.getData(key: 'deviceInfo'))
                      .then((value) {
                    navigatAndFinish(context: context, page: Login());
                    CachHelper.removdata(key: "TOKEN");
                    showToast(
                        msg: S.of(context).disconnect,
                        state: ToastStates.error);
                  });
                },
                child: Text(
                  S.of(context).disconnect,
                  style: TextStyle(color: Colors.red),
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(S.of(context).change_language),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('French'),
                                  onTap: () {
                                    MainCubit.get(context)
                                        .changeLanguage(const Locale('en'));
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Arabic'),
                                  onTap: () {
                                    MainCubit.get(context)
                                        .changeLanguage(const Locale('ar'));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ));
                },
                icon: const Icon(Icons.translate))
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
                      title: Text(S.of(context).username),
                      subtitle: Text(joueurModel.username!),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: joueurModel.username!))
                              .then((_) {
                            showToast(
                                msg: S.of(context).copy_username_success,
                                state: ToastStates.error);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(S.of(context).nom),
                      subtitle: Text(
                        joueurModel.nom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(S.of(context).prenom),
                      subtitle: Text(
                        joueurModel.prenom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(S.of(context).wilaya),
                      subtitle: Text(
                        joueurModel.wilaya!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(S.of(context).email),
                      subtitle: Text(
                        joueurModel.email!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(S.of(context).phone),
                      subtitle: Text(
                        joueurModel.telephone!.toString(),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                child: Text(
                                  S.of(context).modify_profile,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                                child: Text(
                                  S.of(context).modify_password,
                                  style: const TextStyle(
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
