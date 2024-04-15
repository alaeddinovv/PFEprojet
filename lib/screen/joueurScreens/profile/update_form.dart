import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';

import '../../../Model/user_model.dart';
import '../home/cubit/home_joueur_cubit.dart';
import 'cubit/profile_cubit.dart';


class UpdateJoueurForm extends StatefulWidget {
  const UpdateJoueurForm({super.key});

  @override
  State<UpdateJoueurForm> createState() => _UpdateJoueurFormState();
}

class _UpdateJoueurFormState extends State<UpdateJoueurForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _wilayaController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late final DataJoueurModel homeJoueurCubit;
  @override
  void initState() {
    // TODO: implement setState
    homeJoueurCubit = HomeJoueurCubit.get(context).joueurModel!;
    _nomController.text = homeJoueurCubit.nom!;
    _prenomController.text = homeJoueurCubit.prenom!;
    _wilayaController.text = homeJoueurCubit.wilaya!;
    _telephoneController.text = homeJoueurCubit.telephone!.toString();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nomController.dispose();
    _prenomController.dispose();
    _wilayaController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(children: [

                BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                  builder: (context, state) {
                    if (state is UpdateJoueurLoadingState) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    BlocBuilder<ProfileJoueurCubit, ProfileJoueurState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: ProfileJoueurCubit.get(context)
                              .imageCompress !=
                              null
                              ? FileImage(
                              ProfileJoueurCubit.get(context).imageCompress!)
                              : homeJoueurCubit.photo != null
                              ? NetworkImage(homeJoueurCubit.photo!)
                              : const AssetImage('assets/images/user.png')
                          as ImageProvider<Object>,
                          radius: 60,
                        );
                      },
                    ),
                    IconButton(
                      splashRadius: double.minPositive,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const SelectPhotoAlert());
                      },
                      icon: const CircleAvatar(
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultForm2(
                    controller: _nomController,
                    textInputAction: TextInputAction.next,
                    label: 'Nom',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _prenomController,
                    textInputAction: TextInputAction.next,
                    label: 'Prenom',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Prenom Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _wilayaController,
                    textInputAction: TextInputAction.next,
                    label: 'Wilaya',
                    prefixIcon: const Icon(Icons.location_city),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Wilaya Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _telephoneController,
                    textInputAction: TextInputAction.next,
                    label: 'Telephone',
                    prefixIcon: const Icon(Icons.phone),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<ProfileJoueurCubit, ProfileJoueurState>(
                    listener: (context, state) {
                      if (state is UpdateJoueurLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }

                      if (state is UpdateJoueurStateGood) {
                        showToast(msg: "Succes", state: ToastStates.success);
                        HomeJoueurCubit.get(context).getMyInfo().then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileJoueur()),
                                (route) => false,
                          );
                        });
                      }
                    },
                    builder: (context, state) {
                      return defaultSubmit2(
                          text: 'Update',
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              // if (state is LodinUpdateResponsableState) {
                              //   return null;
                              // }
                              ProfileJoueurCubit.get(context).updateJoueur(
                                  nom: _nomController.text,
                                  prenom: _prenomController.text,
                                  telephone: _telephoneController.text,
                                  wilaya: _wilayaController.text,
                                  deleteOldImage: homeJoueurCubit.photo);
                            }
                          });
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectPhotoAlert extends StatelessWidget {
  const SelectPhotoAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choose the source :"),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileJoueurCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: const Text("Camera")),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileJoueurCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: const Text("Gallery"))
      ],
    );
  }
}
