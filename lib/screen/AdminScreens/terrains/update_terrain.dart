import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/add_time_block.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/location/add_location_terrain.dart';

class EditTerrainPage extends StatefulWidget {
  final TerrainModel terrainModel;

  const EditTerrainPage({Key? key, required this.terrainModel})
      : super(key: key);

  @override
  _EditTerrainPageState createState() => _EditTerrainPageState();
}

class _EditTerrainPageState extends State<EditTerrainPage> {
  final ImagePicker _picker = ImagePicker();

  List<dynamic> displayImages = [];

  List<String> imagesToDelete = [];

  final _formKey = GlobalKey<FormState>();

  late final TerrainCubit cubit;

  final TextEditingController _adresseController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();

  final TextEditingController _longitudeController = TextEditingController();

  final TextEditingController _largeurController = TextEditingController();

  final TextEditingController _longueurController = TextEditingController();

  // final TextEditingController _superficieController = TextEditingController();

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
    // _superficieController.text = widget.terrainModel.superficie!.toString();
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
    // _superficieController.dispose();
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
          title: const Text('Modifier le terrain'),
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
                    labelText: 'Durée',
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
                        return 'L\'adresse ne doit pas être vide';
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
                        return 'La description ne doit pas être vide';
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
                          return 'La largeur ne doit pas être vide';
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
                          return 'La longueur ne doit pas être vide';
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
                          return 'Le prix ne doit pas être vide';
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
                          return 'La capacité ne doit pas être vide';
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
                        return 'L\'état ne doit pas être vide';
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
                              return 'La latitude ne doit pas être vide';
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
                              return 'La longitude ne doit pas être vide';
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
                      text: 'bloc de temps',
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
                        'Ajouter des images',
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
                        borderRadius: BorderRadius.circular(12),
// Rounded corners

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
                  BlocConsumer<TerrainCubit, TerrainState>(
                    listener: (context, state) {
                      if (state is UpdateTerrainLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }

                      if (state is UpdateTerrainStateGood) {
                        showToast(
                            msg: 'Terrain mis à jour avec succès',
                            state: ToastStates.success);
                        cubit.getMyTerrains().then((value) {
                          Navigator.pop(context);
                        });
                      } else if (state is ErrorState) {
                        showToast(
                            msg: state.errorModel.message!,
                            state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is UpdateTerrainLoadingState)
                            const LinearProgressIndicator(),
                          defaultSubmit2(
                            text: 'Mise à jour du terrain',
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
                                  // "superficie": _superficieController.text,
                                  "prix": _prixController.text,
                                  "capacite": _capaciteController.text,
                                  "etat": _etatController.text,
                                  "heure_debut_temps": _sTempsController.text,
                                  "heure_fin_temps": _eTempsController.text,
                                  "nonReservableTimeBlocks": widget
                                      .terrainModel.nonReservableTimeBlocks!,
                                  "duree_creneau": _dureeController.text,
                                  // 'photos': displayImages   //! ni neb3etha fl cubit b3d ma nrd photo url
                                };
                                cubit.updateTerrain(
                                    id: widget.terrainModel.id!,
                                    model: _model,
                                    photos: displayImages,
                                    imagesToDelete: imagesToDelete);
                              }
                            },
                          ),
                        ],
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

  void _removeImage(int index) {
    if (displayImages[index] is String) {
      // Assuming URLs are strings
      imagesToDelete.add(displayImages[index]);
    }
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
              msg: "Vous ne pouvez ajouter que 3 images maximum.",
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
      print("Aucun bloc horaire valide ajouté");
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
                  icon: Icon(Icons.save, color: greenConst),
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
                          title: const Text('Supprimer le bloc horaire'),
                          content: const Text(
                              'Etes-vous sûr de vouloir supprimer ce bloc horaire ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.terrainModel.nonReservableTimeBlocks!
                                      .removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('oui'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Non'),
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
