import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';

class UpdateAdminForm extends StatefulWidget {
  const UpdateAdminForm({super.key});

  @override
  State<UpdateAdminForm> createState() => _UpdateAdminFormState();
}

class _UpdateAdminFormState extends State<UpdateAdminForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _wilayaController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late final DataAdminModel homeAdminCubit;
  @override
  void initState() {
    // TODO: implement setState
    homeAdminCubit = HomeAdminCubit.get(context).adminModel!;
    _nomController.text = homeAdminCubit.nom!;
    _prenomController.text = homeAdminCubit.prenom!;
    _wilayaController.text = homeAdminCubit.wilaya!;
    _telephoneController.text = homeAdminCubit.telephone!.toString();

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
                // if (state is UpdateAdminLoadingState)
                BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                  builder: (context, state) {
                    if (state is UpdateAdminLoadingState) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: ProfileAdminCubit.get(context)
                                      .imageCompress !=
                                  null
                              ? FileImage(
                                  ProfileAdminCubit.get(context).imageCompress!)
                              : homeAdminCubit.photo != null
                                  ? NetworkImage(homeAdminCubit.photo!)
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
                  child: BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
                    listener: (context, state) {
                      if (state is UpdateAdminLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }

                      if (state is UpdateAdminStateGood) {
                        showToast(msg: "Succes", state: ToastStates.success);
                        HomeAdminCubit.get(context).getMyInfo().then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileAdmin()),
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
                              ProfileAdminCubit.get(context).updateAdmin(
                                  nom: _nomController.text,
                                  prenom: _prenomController.text,
                                  telephone: _telephoneController.text,
                                  wilaya: _wilayaController.text,
                                  deleteOldImage: homeAdminCubit.photo);
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
              await ProfileAdminCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: const Text("Camera")),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileAdminCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: const Text("Gallery"))
      ],
    );
  }
}
