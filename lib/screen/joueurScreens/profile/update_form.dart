import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Api/wilaya_list.dart';
import 'package:pfeprojet/Model/user_model.dart';

import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/screen/JoueurScreens/profile/profile.dart';
import 'package:pfeprojet/screen/joueurScreens/home/cubit/home_joueur_cubit.dart';




import 'cubit/profile_cubit.dart';


class UpdateJoueurForm extends StatefulWidget {

  const UpdateJoueurForm({super.key});
  // final DataJoueurModel
  // joueurModel;

  @override
  State<UpdateJoueurForm> createState() => _UpdateJoueurFormState();
}

class _UpdateJoueurFormState extends State<UpdateJoueurForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  // final TextEditingController _wilayaController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _posteController = TextEditingController();
  String? selectedWilaya;
  List<dynamic> wilayas = [];

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
    // selectedWilaya = homeJoueurCubit.wilaya;
     final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
      selectedWilaya = homeJoueurCubit.wilaya ?? (wilayas.isNotEmpty ? wilayas[0]['name'] : null);
    });
  }

  // void loadWilayas() {
  //   final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
  //   setState(() {
  //     wilayas = parsed['Wilayas'];
  //     selectedWilaya = widget.joueurModel.wilaya ?? (wilayas.isNotEmpty ? wilayas[0]['name'] : null);
  //     // updateCommunes(selectedWilaya);
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    _ageController.dispose();
    _posteController.dispose();
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
                    } else if (state is ErrorState) {
                      showToast(msg: ' ${state.errorModel.message}', state: ToastStates.error);
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
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    label: 'Nom',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
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
                // defaultForm2(
                //     controller: _wilayaController,
                //     textInputAction: TextInputAction.next,
                //     label: 'Wilaya',
                //     prefixIcon: const Icon(Icons.location_city),
                //     type: TextInputType.text,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Wilaya Must Be Not Empty";
                //       }
                //     }),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Wilaya',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedWilaya,
                  onChanged: (newValue) {
                    setState(() {
                      selectedWilaya = newValue;

                    });
                  },
                  items: wilayas.map<DropdownMenuItem<String>>((dynamic wilaya) {
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
                    label: 'Telephone',
                    prefixIcon: const Icon(Icons.phone),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _ageController,
                    textInputAction: TextInputAction.next,
                    label: 'age',
                    prefixIcon: const Icon(Icons.numbers),
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "age Must Be Not Empty";
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm2(
                    controller: _posteController,
                    textInputAction: TextInputAction.next,
                    label: 'poste',
                    prefixIcon: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Prenom Must Be Not Empty";
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
                                  username: _usernameController.text,
                                  nom: _nomController.text,
                                  prenom: _prenomController.text,
                                  telephone: _telephoneController.text,
                                  wilaya: selectedWilaya,
                                  // wilaya: _wilayaController.text,
                                  poste: _posteController.text,
                                  age: _ageController.text,
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
