import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Model/annonce/annonce_admin_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/screen/AdminScreens/annonce/cubit/annonce_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/addannonce.dart';
import 'package:pfeprojet/generated/l10n.dart';

class EditAnnoncePage extends StatefulWidget {
  final AnnonceAdminData annonceModel;

  const EditAnnoncePage({Key? key, required this.annonceModel})
      : super(key: key);

  @override
  _EditAnnoncePageState createState() => _EditAnnoncePageState();
}

class _EditAnnoncePageState extends State<EditAnnoncePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _wilayaController;
  late TextEditingController _dairaController;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.annonceModel.type);
    _descriptionController =
        TextEditingController(text: widget.annonceModel.description);
    _wilayaController = TextEditingController(text: widget.annonceModel.wilaya);
    _dairaController = TextEditingController(text: widget.annonceModel.commune);
    this._selectedType = widget.annonceModel.type;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _wilayaController.dispose();
    _dairaController.dispose();
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
          title: Text(S.of(context).edit_announcement),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  BlocBuilder<AnnonceCubit, AnnonceState>(
                    builder: (context, state) {
                      if (state is UpdateAnnonceLoadingState) {
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
                    controller: _descriptionController,
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
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  DropdownScreen(
                    selectedDaira: _dairaController,
                    selectedWilaya: _wilayaController,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AnnonceCubit, AnnonceState>(
                    listener: (context, state) {
                      if (state is UpdateAnnonceLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateAnnonceStateGood) {
                        showToast(
                            msg: S.of(context).success,
                            state: ToastStates.success);
                        AnnonceCubit.get(context)
                            .getMyAnnonce(cursor: "")
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else if (state is UpdateAnnonceStateBad) {
                        showToast(
                            msg: S.of(context).failure,
                            state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            defaultSubmit2(
                              text: S.of(context).update,
                              background: Colors.blueAccent,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AnnonceCubit.get(context).updateAnnonce(
                                    id: widget.annonceModel.id!,
                                    type: _titleController.text,
                                    description: _descriptionController.text,
                                    wilaya: _wilayaController.text,
                                    commune: _dairaController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
