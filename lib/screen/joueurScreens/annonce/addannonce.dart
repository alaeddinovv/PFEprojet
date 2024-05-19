import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Model/houssem/equipe_model.dart';
import 'package:pfeprojet/component/components.dart';
import 'package:pfeprojet/component/drop_down_wilaya.dart';
import 'package:pfeprojet/component/search_terrain.dart';
import 'package:pfeprojet/generated/l10n.dart'; // Import localization
import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

class AddAnnonce extends StatefulWidget {
  const AddAnnonce({super.key});

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonce> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController idTerrainController = TextEditingController();
  final TextEditingController wilayaController = TextEditingController();
  final TextEditingController communeController = TextEditingController();
  DateTime dateTime = DateTime.now();
  EquipeModelData? selectedEquipe;
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  int? _numeroJoueurs;
  String? terrainName;
  final List<String> _positions = [
    'attaquant',
    'defenseur',
    'gardia',
    'milieu'
  ];
  List<String?> _selectedPositions = [];
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // navigatAndReturn(context: context, page: AnnouncementPage());
          },
        ),
        appBar: AppBar(
          title: Text(S.of(context).add_annonce), // Localized string
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double padding = width > 600 ? 32.0 : 16.0;
            double fieldWidth = width > 600 ? 500.0 : double.infinity;

            return Center(
              child: Container(
                width: fieldWidth,
                padding: EdgeInsets.all(padding),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      buildDropdownField(
                        context: context,
                        label: S.of(context).type, // Localized string
                        value: _selectedType,
                        items: [
                          S.of(context).search_joueur,
                          S.of(context).search_join_equipe,
                          S.of(context).other
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                        icon: Icons.category,
                      ),
                      const SizedBox(height: 16),
                      if (_selectedType == 'search joueur') ...[
                        SearchTerrain(
                          terrainIdController: idTerrainController,
                          isOnlyMy: false,
                          onTerrainSelected: (p0) {
                            setState(() {
                              idTerrainController.text = p0.id;
                              terrainName = p0.nom;
                            });
                          },
                        ),
                        if (idTerrainController.text.isNotEmpty)
                          Text('${S.of(context).terrain_name}: $terrainName',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              )),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTimePickerField(
                                  context,
                                  hourController,
                                  S.of(context).start_time), // Localized string
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${S.of(context).date}: ${DateFormat('dd/MM/yyyy').format(dateTime)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () =>
                                          dateTimePicker(context, dateTime),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (selectedEquipe != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${S.of(context).selected_equipe}: ${selectedEquipe!.nom}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedEquipe = null;
                                    });
                                  },
                                  icon: const Icon(Icons.clear))
                            ],
                          ),
                        buildTextField(
                          context: context,
                          label: S
                              .of(context)
                              .number_of_players, // Localized string
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              int? numPlayers = int.tryParse(value!);
                              if (numPlayers != null && numPlayers <= 5) {
                                _numeroJoueurs = numPlayers;
                                _selectedPositions =
                                    List.filled(_numeroJoueurs ?? 0, null);
                                _errorMessage = null;
                              } else {
                                _numeroJoueurs = null;
                                _selectedPositions = [];
                                _errorMessage = S
                                    .of(context)
                                    .number_of_players_error; // Localized string
                              }
                            });
                          },
                          icon: Icons.people,
                        ),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        for (int i = 0; i < (_numeroJoueurs ?? 0); i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: buildDropdownField(
                              context: context,
                              label:
                                  '${S.of(context).position_for_player} ${i + 1}', // Localized string
                              value: _selectedPositions[i],
                              items: _positions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPositions[i] = value;
                                });
                              },
                              icon: Icons.sports_soccer,
                            ),
                          ),
                      ],
                      const SizedBox(height: 16),
                      DropdownScreen(
                        selectedDaira: communeController,
                        selectedWilaya: wilayaController,
                      ),
                      buildTextField(
                        context: context,
                        label: S.of(context).description, // Localized string
                        maxLines: 3,
                        icon: Icons.description,
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 20),
                      BlocListener<TerrainCubit, TerrainState>(
                        listener: (context, state) {
                          if (state is GetMyReserveStateGood) {
                            Map<String, dynamic> _model = {
                              "type": _selectedType,
                              "description": descriptionController.text,
                              "terrain_id": state.reservations.terrainId,
                              "reservation_id": state.reservations.id,
                              "numero_joueurs": _numeroJoueurs,
                              'wilaya': wilayaController.text,
                              'commune': communeController.text,
                              "post_want": _selectedPositions.map((position) {
                                return {
                                  "post": position,
                                };
                              }).toList(),
                            };

                            AnnonceJoueurCubit.get(context)
                                .creerAnnonceJoueur(model: _model);
                          } else if (state is ErrorState) {
                            showToast(
                                msg: state.errorModel.message!,
                                state: ToastStates.error);
                          }
                        },
                        child: BlocConsumer<AnnonceJoueurCubit,
                            AnnonceJoueurState>(
                          listener: (context, state) {
                            if (state is CreerAnnonceJoueurLoadingState) {
                              canPop = false;
                            } else {
                              canPop = true;
                            }
                            if (state is CreerAnnonceJoueurStateGood) {
                              showToast(
                                  msg: S
                                      .of(context)
                                      .annonce_published_success, // Localized string
                                  state: ToastStates.success);
                              AnnonceJoueurCubit.get(context)
                                  .getMyAnnonceJoueur(cursor: "")
                                  .then((value) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeJoueur()),
                                  (route) => false,
                                );
                              });
                            } else if (state is CreerAnnonceJoueurStateBad) {
                              showToast(
                                  msg: S
                                      .of(context)
                                      .server_crashed, // Localized string
                                  state: ToastStates.error);
                            } else if (state is ErrorStateAnnonce) {
                              String errorMessage = state.errorModel.message!;
                              showToast(
                                  msg: errorMessage, state: ToastStates.error);
                            }
                          },
                          builder: (context, state) {
                            if (state is CreerAnnonceJoueurLoadingState) {
                              return const CircularProgressIndicator();
                            }
                            return defaultSubmit2(
                                text: S
                                    .of(context)
                                    .add_annonce, // Localized string
                                onPressed: () {
                                  if (_selectedType == 'search joueur' &&
                                      (idTerrainController.text.isEmpty ||
                                          hourController.text.isEmpty ||
                                          // dateTime == null ||
                                          _numeroJoueurs == null ||
                                          _numeroJoueurs! > 5 ||
                                          _selectedPositions.contains(null) ||
                                          wilayaController.text.isEmpty ||
                                          communeController.text.isEmpty ||
                                          descriptionController.text.isEmpty)) {
                                    showToast(
                                        msg: S
                                            .of(context)
                                            .fill_all_fields, // Localized string
                                        state: ToastStates.error);
                                  } else if (_selectedType == 'search joueur') {
                                    TerrainCubit.get(context).getMyreserve(
                                        terrainId: idTerrainController.text,
                                        date: dateTime,
                                        heure_debut_temps: hourController.text);
                                  } else if (_selectedType == 'other') {
                                    Map<String, dynamic> _model = {
                                      "type": _selectedType,
                                      "description": descriptionController.text,
                                      "wilaya": wilayaController.text,
                                      "commune": communeController.text
                                    };
                                    AnnonceJoueurCubit.get(context)
                                        .creerAnnonceJoueur(model: _model);
                                  }
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimePickerField(BuildContext context,
      TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              readOnly: true,
              onTap: () => _selectTime(context, controller),
              validator: (value) => value == null || value.isEmpty
                  ? S.of(context).select_time_error // Localized string
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (pickedTime != null) {
      String formattedTime = _formatTimeOfDay(pickedTime);
      controller.text = formattedTime;
      print(controller.text);
    }
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat("HH:mm");
    return format.format(dt);
  }

  Future<void> dateTimePicker(BuildContext context, DateTime dateTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != dateTime) {
      setState(() {
        this.dateTime = pickedDate;
      });
    }
  }
}

Widget buildDropdownField({
  required BuildContext context,
  required String label,
  String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  required IconData icon,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null
          ? '${S.of(context).select} $label'
          : null, // Localized string
    ),
  );
}

Widget buildTextField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  FormFieldSetter<String>? onChanged,
  FormFieldValidator<String>? validator,
  required IconData icon,
  TextEditingController? controller,
  required BuildContext context,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '${S.of(context!).enter} $label'; // Localized string
            }
            return null;
          },
    ),
  );
}
