import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/location/add_location_terrain.dart';

class EditTerrainPage extends StatefulWidget {
  // Assuming AnnonceModel is your data model
  final TerrainModel terrainModel;

  const EditTerrainPage({Key? key, required this.terrainModel})
      : super(key: key);

  @override
  _EditTerrainPageState createState() => _EditTerrainPageState();
}

class _EditTerrainPageState extends State<EditTerrainPage> {
  final ImagePicker _picker = ImagePicker();
  List<dynamic> displayImages = [];
  final _formKey = GlobalKey<FormState>();
  late final TerrainCubit cubit;

  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final TextEditingController _largeurController = TextEditingController();
  final TextEditingController _longueurController = TextEditingController();
  final TextEditingController _superficieController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _dureeController = TextEditingController();
  final TextEditingController _capaciteController = TextEditingController();
  final TextEditingController _etatController = TextEditingController();
  final TextEditingController _sTempsController = TextEditingController();
  final TextEditingController _eTempsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = TerrainCubit.get(context);
    displayImages.addAll(widget.terrainModel.photos!);

    _adresseController.text = widget.terrainModel.adresse!;
    _descriptionController.text = widget.terrainModel.description!;
    _latitudeController.text =
        widget.terrainModel.coordonnee!.latitude.toString();
    _longitudeController.text =
        widget.terrainModel.coordonnee!.longitude.toString();
    _largeurController.text = widget.terrainModel.largeur!.toString();
    _longueurController.text = widget.terrainModel.longeur!.toString();
    _superficieController.text = widget.terrainModel.superficie!.toString();
    _prixController.text = widget.terrainModel.prix!.toString();
    _dureeController.text = widget.terrainModel.dureeCreneau!.toString();
    _capaciteController.text = widget.terrainModel.capacite!.toString();
    _etatController.text = widget.terrainModel.etat!;
    _sTempsController.text = widget.terrainModel.heureDebutTemps!;
    _eTempsController.text = widget.terrainModel.heureFinTemps!;
  }

  @override
  void dispose() {
    _adresseController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _largeurController.dispose();
    _longueurController.dispose();
    _superficieController.dispose();
    _prixController.dispose();
    _dureeController.dispose();
    _capaciteController.dispose();
    _etatController.dispose();
    _sTempsController.dispose();
    _eTempsController.dispose();

    super.dispose();
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapPickerPage(
          latitudeController: _latitudeController,
          longitudeController: _longitudeController,
        ),
      ),
    );
  }
  // The latitude and longitude text fields are updated only if the user presses the check icon

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
          title: const Text('Edit Terrain'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                // padding: const EdgeInsets.all(16),
                children: <Widget>[
                  buildTimeRow(context, _sTempsController, _eTempsController),
                  const SizedBox(height: 10),
                  defaultForm3(
                    // ! hta nrigl duree yrje3 form HH:MM
                    // enabled: false,
                    controller: _dureeController,
                    labelText: 'Duree',
                    type: TextInputType.number,
                    context: context,
                    valid: (String value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultForm3(
                    controller: _adresseController,
                    labelText: 'Adresse',
                    context: context,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Adresse Must Not Be Empty';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  defaultForm3(
                    controller: _descriptionController,
                    labelText: 'Description',
                    maxline: 3,
                    context: context,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Description Must Not Be Empty';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  defaultForm3(
                      controller: _largeurController,
                      labelText: 'Largeur',
                      context: context,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                      },
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  defaultForm3(
                      controller: _longueurController,
                      labelText: 'Longueur',
                      context: context,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                      },
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  defaultForm3(
                      controller: _superficieController,
                      labelText: 'Superficie',
                      context: context,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                      },
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  defaultForm3(
                      controller: _prixController,
                      labelText: 'Prix',
                      context: context,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                      },
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  defaultForm3(
                      controller: _capaciteController,
                      labelText: 'Capacité',
                      context: context,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return 'Type Must Not Be Empty';
                        }
                      },
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  defaultForm3(
                    controller: _etatController,
                    labelText: 'État',
                    context: context,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Type Must Not Be Empty';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () =>
                                _navigateAndDisplaySelection(context),
                            icon: Icon(
                              size: 36,
                              Icons.gps_fixed,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      Expanded(
                        child: defaultForm3(
                          controller: _latitudeController,
                          context: context,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Type Must Not Be Empty';
                            }
                          },
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: defaultForm3(
                          controller: _longitudeController,
                          context: context,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Type Must Not Be Empty';
                            }
                          },
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<TerrainCubit, TerrainState>(
                    builder: (BuildContext context, state) {
                      return Column(
                        children: [
                          ..._buildTimeBlocksList(state),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  defaultSubmit2(
                      text: 'Add Time Block',
                      onPressed: () {
                        _addTimeBlock(context, widget.terrainModel);
                      },
                      width: 200,
                      background: Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        highlightColor: Colors.transparent,
                        iconSize: 30,
                        onPressed: _pickImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Add Images',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: displayImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      var image = displayImages[index];
                      Widget imageWidget;

                      if (image is String) {
                        imageWidget = Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      } else if (image is File) {
                        imageWidget = Image.file(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      } else {
                        imageWidget = const Placeholder();
                      }
                      return ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: imageWidget),
                            Container(
                              margin: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                highlightColor: Colors.transparent,
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => _removeImage(index),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultSubmit2(
                    text: 'Update Terrain',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> _model = {
                          "adresse": _adresseController.text,
                          "description": _descriptionController.text,
                          "coordonnee": {
                            "latitude": _latitudeController.text,
                            "longitude": _longitudeController.text,
                          },
                          "largeur": _largeurController.text,
                          "longeur": _longueurController.text,
                          "superficie": _superficieController.text,
                          "prix": _prixController.text,
                          "capacite": _capaciteController.text,
                          "etat": _etatController.text,
                          "heure_debut_temps": _sTempsController.text,
                          "heure_fin_temps": _eTempsController.text,
                          "nonReservableTimeBlocks":
                              widget.terrainModel.nonReservableTimeBlocks!,
                          "duree_creneau": _dureeController.text,
                          // 'photos': displayImages   //! ni neb3etha fl cubit b3d ma nrd photo url
                        };
                        cubit.updateTerrain(
                            id: widget.terrainModel.id!,
                            model: _model,
                            photos: displayImages);
                      }
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

  void _removeImage(int index) {
    setState(() {
      displayImages.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      List<File> selectedImages =
          pickedFiles.map((file) => File(file.path)).toList();
      int availableSlots = 3 - displayImages.length;

      for (var image in selectedImages) {
        if (selectedImages.length <= availableSlots) {
          await FlutterImageCompress.compressAndGetFile(
            image.absolute.path,
            '${image.path}.jpg',
            quality: 10,
          ).then((value) {
            setState(() {
              displayImages.add(File(value!.path));
            });
          });
        } else {
          showToast(
              msg: "You can only add up to 3 images.",
              state: ToastStates.error);
          break;
        }
      }
    }
  }

  void _addTimeBlock(BuildContext context, TerrainModel terrainModel) async {
    final result = await showDialog<NonReservableTimeBlocks>(
      context: context,
      builder: (context) => const AddTimeBlockDialog(),
    );
    if (result != null && result.hours!.isNotEmpty) {
      setState(() {
        terrainModel.nonReservableTimeBlocks!.add(result);
      });
    } else {
      print("No valid time block added");
    }
  }

  List<Widget> _buildTimeBlocksList(TerrainState state) {
    return List.generate(widget.terrainModel.nonReservableTimeBlocks!.length,
        (index) {
      var block = widget.terrainModel.nonReservableTimeBlocks![index];
      if (state is EditingNonReservableTimeBlock && state.index == index) {
        return Column(
          children: [
            TextField(
              controller: TextEditingController(text: block.day),
              // Update day on change or after editing is done
              onChanged: (newDay) {
                block.day = newDay;
              },
            ),
            TextField(
              controller: TextEditingController(text: block.hours!.join(', ')),
              // Update hours on change
              onChanged: (newHours) {
                // block.hours = newHours.split(',').map((e) => e.trim()).toList();
                block.hours = newHours
                    .split(',')
                    .map((e) => normalizeTimeInput(e.trim()))
                    .where((hour) => hour != "Invalid Time")
                    .toList();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.save, color: Colors.green),
                  onPressed: () => cubit.editeOneOfNonReservableTimeBlock(null),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () => cubit.editeOneOfNonReservableTimeBlock(null),
                ),
              ],
            )
          ],
        );
      } else {
        return ListTile(
          title: Text("${block.day}: ${block.hours!.join(', ')}"),
          trailing: Wrap(
            spacing: 12, // space between two icons
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => {
                  cubit.editeOneOfNonReservableTimeBlock(index),
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Time Block'),
                          content: const Text(
                              'Are you sure you want to delete this time block?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.terrainModel.nonReservableTimeBlocks!
                                      .removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      })
                },
              ),
            ],
          ),
        );
      }
    });
  }
}

class AddTimeBlockDialog extends StatefulWidget {
  const AddTimeBlockDialog({Key? key}) : super(key: key);

  @override
  _AddTimeBlockDialogState createState() => _AddTimeBlockDialogState();
}

class _AddTimeBlockDialogState extends State<AddTimeBlockDialog> {
  String? selectedDay;
  List<String> hours = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Non-Reservable Time Block'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            hint: const Text('Select Day'),
            value: selectedDay,
            onChanged: (value) => setState(() => selectedDay = value),
            items: [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ]
                .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                .toList(),
          ),
          TextField(
            onSubmitted: (value) {},
            decoration:
                const InputDecoration(hintText: 'Hours (e.g., 8, 9:30, 8.30)'),
            onChanged: (value) {
              hours = value
                  .split(',')
                  .map((e) => normalizeTimeInput(e.trim()))
                  .where((hour) => hour != "Invalid Time")
                  .toList();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (selectedDay != null && hours.isNotEmpty) {
                Navigator.of(context).pop(
                    NonReservableTimeBlocks(day: selectedDay!, hours: hours));
              }
            },
            child: const Text('Add')),
      ],
    );
  }
}
