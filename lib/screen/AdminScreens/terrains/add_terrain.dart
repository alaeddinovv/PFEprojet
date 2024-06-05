import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfeprojet/Api/color.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/add_time_block.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/const.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/location/add_location_terrain.dart';
import 'package:pfeprojet/screen/AdminScreens/terrains/cubit/terrain_cubit.dart';

class AddTerrainPage extends StatefulWidget {
  const AddTerrainPage({Key? key}) : super(key: key);

  @override
  State<AddTerrainPage> createState() => _AddTerrainPageState();
}

class _AddTerrainPageState extends State<AddTerrainPage> {
  final formKey = GlobalKey<FormState>();
  late final TerrainCubit terrainCubit;

  final TextEditingController _nameController = TextEditingController();
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
    terrainCubit = TerrainCubit.get(context);

    super.initState();
  }

  @override
  void dispose() {
    _adresseController.dispose();
    _nameController.dispose();
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
    terrainCubit.clearNonReservableTimeBlocks();
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
    TerrainCubit cubit = TerrainCubit.get(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<Map<String, dynamic>> nonReservableTimeBlockstoJsonArray() {
            return cubit.nonReservableTimeBlocks
                .map((block) => block.toJson())
                .toList();
          }

          print(nonReservableTimeBlockstoJsonArray());
        },
      ),
      appBar: AppBar(title: const Text('Add Terrain')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildTimeRow(context, _sTempsController, _eTempsController),
                const SizedBox(height: 10),
                defaultForm3(
                  // ! hta nrigl duree yrje3 form HH:MM
                  // enabled: false,
                  controller: _nameController,
                  labelText: 'nom',
                  type: TextInputType.text,
                  context: context,
                  valid: (String value) {},
                ),
                SizedBox(height: 10),
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
                        readOnly:
                            true, // Make this read-only if the value is set from the map
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
                        readOnly:
                            true, // Make this read-only if the value is set from the map
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<TerrainCubit, TerrainState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ...terrainCubit.nonReservableTimeBlocks
                            .asMap()
                            .entries
                            .map((entry) {
                          int idx = entry.key;
                          NonReservableTimeBlocks block = entry.value;
                          // Return widgets for editing, e.g., TextFields for day and hours
                          if (state is EditingNonReservableTimeBlock &&
                              state.index == idx) {
                            return Column(
                              children: [
                                TextField(
                                  controller:
                                      TextEditingController(text: block.day),
                                  // Update day on change or after editing is done
                                  onChanged: (newDay) {
                                    block.day = newDay;
                                  },
                                ),
                                TextField(
                                  controller: TextEditingController(
                                      text: block.hours!.join(', ')),
                                  // Update hours on change
                                  onChanged: (newHours) {
                                    // block.hours = newHours
                                    //     .split(',')
                                    //     .map((e) => e.trim())
                                    //     .toList();
                                    block.hours = newHours
                                        .split(',')
                                        .map(
                                            (e) => normalizeTimeInput(e.trim()))
                                        .where((hour) => hour != "Invalid Time")
                                        .toList();
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.save, color: greenConst),
                                      onPressed: () => terrainCubit
                                          .editeOneOfNonReservableTimeBlock(
                                              null),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      onPressed: () => terrainCubit
                                          .editeOneOfNonReservableTimeBlock(
                                              null),
                                    ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return ListTile(
                              title: Text(
                                  "${block.day}: ${block.hours!.join(', ')}"), //day and hours
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => terrainCubit
                                        .editeOneOfNonReservableTimeBlock(idx),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _showDeleteConfirmation(
                                        idx, context, cubit),
                                  ),
                                ],
                              ),
                            );
                          }
                        }).toList(),
                      ],
                    );
                  },
                ),
                BlocListener<TerrainCubit, TerrainState>(
                  listener: (context, state) {
                    if (state is DublicatedAddNonReservableTimeBlockState) {
                      showToast(
                          msg: "dublicated Day ", state: ToastStates.warning);
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        _addTimeBlock(context, cubit);
                      },
                      child: const Text('Add Time Block')),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      highlightColor: Colors.transparent,
                      iconSize: 30,
                      onPressed: cubit.pickImages,
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
                const SizedBox(height: 20),
                BlocBuilder<TerrainCubit, TerrainState>(
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
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
                                child: Image.file(
                                  cubit.images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
                                  onPressed: () => cubit.removeImage(index),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocConsumer<TerrainCubit, TerrainState>(
                  listener: (context, state) {
                    if (state is CreerTerrainStateGood) {
                      showToast(
                          msg: 'Terrain Created Successfully',
                          state: ToastStates.success);
                      cubit.getMyTerrains().then((value) {
                        Navigator.of(context).pop();
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
                        if (state is CreerTerrainLoadingState)
                          const LinearProgressIndicator(),
                        defaultSubmit2(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              List<Map<String, dynamic>>
                                  nonReservableTimeBlockstoJsonArray() {
                                return cubit.nonReservableTimeBlocks
                                    .map((block) => block.toJson())
                                    .toList();
                              }

                              Map<String, dynamic>? model = {
                                "nom": _nameController.text,
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
                                    nonReservableTimeBlockstoJsonArray(),
                                "duree_creneau": _dureeController.text,
                                // "photos": cubit.images,
                              };

                              TerrainCubit.get(context).creerTarrain(
                                model: model,
                              );
                            }
                          },
                          text: 'Create Terrain',
                          background: Colors.blueAccent,
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
    );
  }
}

void _addTimeBlock(BuildContext context, TerrainCubit cubit) async {
  final result = await showDialog<NonReservableTimeBlocks>(
    context: context,
    builder: (context) => const AddTimeBlockDialog(),
  );
  if (result != null && result.hours!.isNotEmpty) {
    cubit.addNonReservableTimeBlock(result);
  } else {
    // Optionally handle the case where no valid time block was added
    print("No valid time block added");
    // showToast(msg: 'No valid time block added', state: ToastStates.warning);
  }
}

void _showDeleteConfirmation(
    int index, BuildContext context, TerrainCubit cubit) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this time block?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (result ?? false) {
    cubit.removeNonReservableTimeBlock(index);
  }
}
