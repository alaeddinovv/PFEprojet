import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/update_form.dart';

class ProfileJoueur extends StatelessWidget {
  const ProfileJoueur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetMyInformationLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: ProfileCubit.get(context)
                                .joueurDataModel!
                                .photo !=
                            ""
                        ? NetworkImage(
                            ProfileCubit.get(context).joueurDataModel!.photo!)
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
                      ProfileCubit.get(context).joueurDataModel!.nom!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Prenom'),
                    subtitle: Text(
                      ProfileCubit.get(context).joueurDataModel!.prenom!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Age'),
                    subtitle: Text(
                      ProfileCubit.get(context)
                          .joueurDataModel!
                          .age!
                          .toString(),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: const Text('Wilaya'),
                    subtitle: Text(
                      ProfileCubit.get(context).joueurDataModel!.wilaya!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(
                      ProfileCubit.get(context).joueurDataModel!.email!,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(ProfileCubit.get(context)
                        .joueurDataModel!
                        .telephone!
                        .toString()),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigatAndReturn(
                          context: context, page: UpdateJoueurForm());
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
