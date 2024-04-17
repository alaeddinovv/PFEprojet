import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    builder: (BuildContext context, state) {
                      return Column(
                        children: [
                          ..._buildTimeBlocksList(state),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
