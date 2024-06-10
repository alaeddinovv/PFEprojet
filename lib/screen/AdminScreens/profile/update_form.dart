import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';
import 'package:pfeprojet/Model/admin_medel.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/profile/profile.dart';
import 'package:pfeprojet/generated/l10n.dart';

class UpdateAdminForm extends StatefulWidget {
  const UpdateAdminForm({super.key});

  @override
  State<UpdateAdminForm> createState() => _UpdateAdminFormState();
}

class _UpdateAdminFormState extends State<UpdateAdminForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  String? selectedWilaya;
  List<dynamic> wilayas = [];
  final formkey = GlobalKey<FormState>();
  late final DataAdminModel homeAdminCubit;

  @override
  void initState() {
    super.initState();

    homeAdminCubit = HomeAdminCubit.get(context).adminModel!;
    _nomController.text = homeAdminCubit.nom!;
    _prenomController.text = homeAdminCubit.prenom!;
    _telephoneController.text = homeAdminCubit.telephone!.toString();

    final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
      selectedWilaya = homeAdminCubit.wilaya ??
          (wilayas.isNotEmpty ? wilayas[0]['name'] : null);
    });
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
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
          title: Text(S.of(context).update),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(children: [
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
                    controller: _nomController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).name,
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).name_cannot_be_empty;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _prenomController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).surname,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).surname_cannot_be_empty;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: S.of(context).select_wilaya,
                    border: OutlineInputBorder(),
                  ),
                  value: selectedWilaya,
                  onChanged: (newValue) {
                    setState(() {
                      selectedWilaya = newValue;
                    });
                  },
                  items:
                      wilayas.map<DropdownMenuItem<String>>((dynamic wilaya) {
                    return DropdownMenuItem<String>(
                      value: wilaya['name'],
                      child: Text(wilaya['name']),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _telephoneController,
                    textInputAction: TextInputAction.next,
                    label: S.of(context).phone,
                    prefixIcon: const Icon(Icons.phone),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).phone_cannot_be_empty;
                      }
                    }),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
                  listener: (context, state) {
                    if (state is UpdateAdminLoadingState) {
                      canPop = false;
                    } else {
                      canPop = true;
                    }

                    if (state is UpdateAdminStateGood) {
                      showToast(
                          msg: S.of(context).success,
                          state: ToastStates.success);
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
                        text: S.of(context).update,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ProfileAdminCubit.get(context).updateAdmin(
                                nom: _nomController.text,
                                prenom: _prenomController.text,
                                telephone: _telephoneController.text,
                                wilaya: selectedWilaya,
                                deleteOldImage: homeAdminCubit.photo);
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
      title: Text(S.of(context).choose_source),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileAdminCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: Text(S.of(context).camera)),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileAdminCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: Text(S.of(context).gallery))
      ],
    );
  }
}
