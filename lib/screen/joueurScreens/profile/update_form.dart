import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/cubit/profile_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/profile/profile.dart';

class UpdateJoueurForm extends StatefulWidget {
  final emailController = TextEditingController();

  UpdateJoueurForm({super.key});

  @override
  State<UpdateJoueurForm> createState() => _UpdateJoueurFormState();
}

class _UpdateJoueurFormState extends State<UpdateJoueurForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _wilayaController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement setState
    _nomController.text = ProfileCubit.get(context).joueurDataModel!.nom!;
    _prenomController.text = ProfileCubit.get(context).joueurDataModel!.prenom!;
    _ageController.text =
        ProfileCubit.get(context).joueurDataModel!.age!.toString();
    _wilayaController.text = ProfileCubit.get(context).joueurDataModel!.wilaya!;
    _telephoneController.text =
        ProfileCubit.get(context).joueurDataModel!.telephone!.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _wilayaController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateJoueurStateGood) {
          showToast(msg: "Succes", state: ToastStates.success);
          navigatAndFinish(context: context, page: const ProfileJoueur());
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (!didPop) {
              if (state is! UpdateJoueurLoadingState) {
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
                    if (state is UpdateJoueurLoadingState)
                      const LinearProgressIndicator(),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: ProfileCubit.get(context)
                                      .imageCompress !=
                                  null
                              ? FileImage(
                                  ProfileCubit.get(context).imageCompress!)
                              : ProfileCubit.get(context)
                                          .joueurDataModel!
                                          .photo !=
                                      ""
                                  ? NetworkImage(ProfileCubit.get(context)
                                      .joueurDataModel!
                                      .photo!)
                                  : const AssetImage('assets/images/user.png')
                                      as ImageProvider<Object>,
                          radius: 60,
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
                        controller: _ageController,
                        textInputAction: TextInputAction.next,
                        label: 'Age',
                        prefixIcon: const Icon(Icons.countertops),
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Age Must Be Not Empty";
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
                      child: defaultSubmit2(
                          text: 'Update',
                          background: Colors.grey,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              // if (state is LodinUpdateResponsableState) {
                              //   return null;
                              // }
                              ProfileCubit.get(context).updateJoueur(
                                nom: _nomController.text,
                                prenom: _prenomController.text,
                                telephone: _telephoneController.text,
                                age: _ageController.text,
                                wilaya: _wilayaController.text,
                              );
                            }
                          }),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
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
              // if (state
              //     is LodinUpdateResponsableState) {
              //   return null;
              // }
              await ProfileCubit.get(context)
                  .imagePickerProfile(ImageSource.camera)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text("Camera")),
        TextButton(
            onPressed: () async {
              // if (state
              //     is LodinUpdateResponsableState) {
              //   return null;
              // }
              await ProfileCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text("Gallery"))
      ],
    );
  }
}
