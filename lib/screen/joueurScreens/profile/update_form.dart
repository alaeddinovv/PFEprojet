import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';
import 'cubit/profile_cubit.dart';
import 'package:pfeprojet/generated/l10n.dart'; // Import the localization file

class UpdateJoueurForm extends StatefulWidget {
  const UpdateJoueurForm({super.key});

  @override
  State<UpdateJoueurForm> createState() => _UpdateJoueurFormState();
}

class _UpdateJoueurFormState extends State<UpdateJoueurForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _posteController = TextEditingController();
  final TextEditingController _wilayaController = TextEditingController();
  final TextEditingController _dairaController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  late final DataJoueurModel homeJoueurCubit;
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    homeJoueurCubit = HomeJoueurCubit.get(context).joueurModel!;
    _usernameController.text = homeJoueurCubit.username!;
    _nomController.text = homeJoueurCubit.nom!;
    _prenomController.text = homeJoueurCubit.prenom!;
    _telephoneController.text = homeJoueurCubit.telephone!.toString();
    _ageController.text = homeJoueurCubit.age!.toString();
    _posteController.text = homeJoueurCubit.poste!;
    _wilayaController.text = homeJoueurCubit.wilaya!;
    _dairaController.text = homeJoueurCubit.commune!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    _ageController.dispose();
    _posteController.dispose();
    _wilayaController.dispose();
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
          title: Text(S.of(context).update), // Localized string
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
                    } else if (state is ErrorState) {
                      showToast(
                          msg: ' ${state.errorModel.message}',
                          state: ToastStates.error);
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
                          backgroundImage:
                              ProfileJoueurCubit.get(context).imageCompress !=
                                      null
                                  ? FileImage(ProfileJoueurCubit.get(context)
                                      .imageCompress!)
                                  : homeJoueurCubit.photo != null
                                      ? NetworkImage(homeJoueurCubit.photo!)
                                      : const AssetImage(
                                              'assets/images/football.png')
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
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).username, // Localized string
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .usernameMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _nomController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).name, // Localized string
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .nameMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _prenomController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).prenom, // Localized string
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .prenomMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                DropdownScreen(
                  selectedDaira: _dairaController,
                  selectedWilaya: _wilayaController,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _telephoneController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).telephone, // Localized string
                    prefixIcon: const Icon(Icons.phone),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .phoneMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _ageController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).age, // Localized string
                    prefixIcon: const Icon(Icons.numbers),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .ageMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _posteController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).poste, // Localized string
                    prefixIcon: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .posteMustNotBeEmpty; // Localized string
                      }
                    }),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<ProfileJoueurCubit, ProfileJoueurState>(
                  listener: (context, state) {
                    if (state is UpdateJoueurLoadingState) {
                      canPop = false;
                    } else {
                      canPop = true;
                    }

                    if (state is UpdateJoueurStateGood) {
                      showToast(
                          msg: S.of(context).success,
                          state: ToastStates.success); // Localized string
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
                        text: S.of(context).update, // Localized string
                        background: Colors.blueAccent,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ProfileJoueurCubit.get(context).updateJoueur(
                                username: _usernameController.text,
                                nom: _nomController.text,
                                prenom: _prenomController.text,
                                telephone: _telephoneController.text,
                                wilaya: _wilayaController.text,
                                commune: _dairaController.text,
                                poste: _posteController.text,
                                age: _ageController.text,
                                deleteOldImage: homeJoueurCubit.photo);
                          }
                        });
                  },
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
      title: Text(S.of(context).chooseSource), // Localized string
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileJoueurCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: Text(S.of(context).camera)), // Localized string
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileJoueurCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: Text(S.of(context).gallery)) // Localized string
      ],
    );
  }
}
