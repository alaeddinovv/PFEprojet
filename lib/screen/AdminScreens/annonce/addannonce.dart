import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/screen/AdminScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/addannonce.dart';
import 'cubit/annonce_cubit.dart';
import 'package:pfeprojet/Api/wilaya_list.dart'; // Import your JSON data
import 'package:pfeprojet/generated/l10n.dart';

class AddAnnonce extends StatefulWidget {
  AddAnnonce({Key? key}) : super(key: key);

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  final TextEditingController _textController = TextEditingController();
  final wilayaController = TextEditingController();
  final dairaController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? selectedWilaya;
  String? selectedCommune;
  List<dynamic> wilayas = [];
  List<String> communes = [];
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    loadWilayas();
  }

  void loadWilayas() {
    final parsed = json.decode(wilayasJson) as Map<String, dynamic>;
    setState(() {
      wilayas = parsed['Wilayas'];
    });
  }

  void updateCommunes(String? wilayaName) {
    setState(() {
      selectedCommune = null; // Reset the commune selection
      communes = wilayaName != null
          ? List<String>.from(wilayas.firstWhere(
              (element) => element['name'] == wilayaName)['communes'])
          : [];
    });
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
          title: Text(S.of(context).add_announcement),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<AnnonceCubit, AnnonceState>(
                    builder: (context, state) {
                      if (state is CreerAnnonceLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox(height: 30);
                    },
                  ),
                  buildDropdownField(
                    context: context,
                    label: S.of(context).type,
                    value: _selectedType,
                    items: [
                      'Concernant le timing',
                      'Perte de propriété',
                      'other'
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    context: context,
                    controller: _textController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return S.of(context).content_cannot_be_empty;
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.grey,
                    ),
                    maxline: 3,
                    labelText: S.of(context).announcement_content,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  DropdownScreen(
                    selectedDaira: dairaController,
                    selectedWilaya: wilayaController,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<AnnonceCubit, AnnonceState>(
                      listener: (context, state) {
                        if (state is CreerAnnonceLoadingState) {
                          canPop = false;
                        } else {
                          canPop = true;
                        }
                        if (state is CreerAnnonceStateGood) {
                          showToast(
                              msg: S
                                  .of(context)
                                  .announcement_published_successfully,
                              state: ToastStates.success);
                          AnnonceCubit.get(context)
                              .getMyAnnonce(cursor: "")
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeAdmin()),
                              (route) => false,
                            );
                          });
                        } else if (state is CreerAnnonceStateBad) {
                          showToast(
                              msg: S.of(context).server_error,
                              state: ToastStates.error);
                        } else if (state is ErrorState) {
                          String errorMessage = state.errorModel.message!;
                          showToast(
                              msg: errorMessage, state: ToastStates.error);
                        }
                      },
                      builder: (context, state) {
                        return defaultSubmit2(
                          text: S.of(context).publish_announcement,
                          background: Colors.blueAccent,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              AnnonceCubit.get(context).creerAnnonce(
                                  type: _selectedType ?? '',
                                  text: _textController.text,
                                  wilaya: wilayaController.text,
                                  commune: dairaController.text);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
