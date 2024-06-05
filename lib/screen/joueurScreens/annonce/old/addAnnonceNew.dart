// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:pfeprojet/Model/houssem/equipe_model.dart';
// import 'package:pfeprojet/component/components.dart';
// import 'package:pfeprojet/screen/JoueurScreens/home/home.dart';
// import 'package:pfeprojet/screen/joueurScreens/annonce/cubit/annonce_joueur_cubit.dart';
// import 'package:pfeprojet/screen/joueurScreens/terrains/cubit/terrain_cubit.dart';

// class AddAnnoncePage extends StatefulWidget {
//   const AddAnnoncePage({super.key});

//   @override
//   _AddAnnoncePageState createState() => _AddAnnoncePageState();
// }

// class _AddAnnoncePageState extends State<AddAnnoncePage> {
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController hourController = TextEditingController();
//   final TextEditingController idTerrainController = TextEditingController();
//   DateTime dateTime = DateTime.now();
//   EquipeModelData? selectedEquipe;
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedType;
//   int? _numeroJoueurs;
//   final List<String> _positions = [
//     'attaquant',
//     'defenseur',
//     'gardia',
//     'milieu'
//   ];
//   List<String?> _selectedPositions = [];
//   String? _errorMessage;
//   @override
//   void initState() {
//     idTerrainController.text = '663e34f963281e6569d72b9a';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool canPop = true;

//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (!didPop) {
//           if (canPop == true) {
//             Navigator.pop(context);
//           }
//         }
//       },
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//         ),
//         appBar: AppBar(
//           title: const Text('Add Annonce'),
//         ),
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             // Get the width of the screen
//             double width = constraints.maxWidth;
//             // Adjust padding based on screen width
//             double padding = width > 600 ? 32.0 : 16.0;
//             // Set a fixed width for larger screens
//             double fieldWidth = width > 600 ? 500.0 : double.infinity;

//             return Center(
//               child: Container(
//                 width: fieldWidth,
//                 padding: EdgeInsets.all(padding),
//                 child: Form(
//                   key: _formKey,
//                   child: ListView(
//                     children: [
//                       // Dropdown field for selecting the type of annonce
//                       buildDropdownField(
//                         label: 'Type',
//                         value: _selectedType,
//                         items: ['search joueur', 'search join equipe', 'other'],
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedType = value;
//                           });
//                         },
//                         icon: Icons.category,
//                       ),
//                       const SizedBox(height: 16),
//                       if (_selectedType == 'search joueur') ...[
//                         // text field for entering the idTerrain

//                         const SizedBox(height: 16),
//                         // text field for entering the idTerrain
//                         buildTextField(
//                           controller: idTerrainController,
//                           label: 'Terrain ID',
//                           keyboardType: TextInputType.text,
//                           onChanged: (value) {
//                             setState(() {
//                               idTerrainController.text = value!;
//                             });
//                           },
//                           icon: Icons.sports_soccer,
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildTimePickerField(
//                                   context, hourController, 'Start Time'),
//                             ),
//                             // date picker
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.black12,
//                                       blurRadius: 6,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         'Date: ${DateFormat('dd/MM/yyyy').format(dateTime)}',
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.calendar_today),
//                                       onPressed: () =>
//                                           dateTimePicker(context, dateTime),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 16),

//                         if (selectedEquipe != null)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Selected Equipe: ${selectedEquipe!.nom}',
//                                 // ignore: prefer_const_constructors
//                                 style: TextStyle(
//                                   color: greenConst,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       selectedEquipe = null;
//                                     });
//                                   },
//                                   icon: const Icon(Icons.clear))
//                             ],
//                           ),

//                         // Text(),
//                         // Text field for entering the number of players
//                         buildTextField(
//                           label: 'Number of Players',
//                           keyboardType: TextInputType.number,
//                           onChanged: (value) {
//                             setState(() {
//                               int? numPlayers = int.tryParse(value!);
//                               if (numPlayers != null && numPlayers <= 5) {
//                                 _numeroJoueurs = numPlayers;
//                                 _selectedPositions =
//                                     List.filled(_numeroJoueurs ?? 0, null);
//                                 _errorMessage = null;
//                               } else {
//                                 _numeroJoueurs = null;
//                                 _selectedPositions = [];
//                                 _errorMessage =
//                                     'Number of players cannot exceed 5';
//                               }
//                             });
//                           },
//                           icon: Icons.people,
//                         ),
//                         // Display error message if number of players exceeds 5
//                         if (_errorMessage != null)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               _errorMessage!,
//                               style: const TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         // Dropdown fields for selecting positions for each player
//                         for (int i = 0; i < (_numeroJoueurs ?? 0); i++)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 16.0),
//                             child: buildDropdownField(
//                               label: 'Position for Player ${i + 1}',
//                               value: _selectedPositions[i],
//                               items: _positions,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedPositions[i] = value;
//                                 });
//                               },
//                               icon: Icons.sports_soccer,
//                             ),
//                           ),
//                       ],
//                       const SizedBox(height: 16),
//                       // Text field for entering the description
//                       buildTextField(
//                         label: 'Description',
//                         maxLines: 3,
//                         icon: Icons.description,
//                         controller: descriptionController,
//                       ),
//                       const SizedBox(height: 20),
//                       // Submit button
//                       BlocListener<TerrainCubit, TerrainState>(
//                         listener: (context, state) {
//                           if (state is GetMyReserveStateGood) {
//                             Map<String, dynamic> _model = {
//                               "type": _selectedType,
//                               "description": descriptionController.text,
//                               "terrain_id": state.reservations.terrainId,
//                               "equipe_id": state.reservations.equipe1!.id,
//                               "reservation_id": state.reservations.id,
//                               "numero_joueurs": _numeroJoueurs,
//                               "post_want": _selectedPositions.map((position) {
//                                 return {
//                                   "post": position,
//                                 };
//                               }).toList(),
//                             };
//                             AnnonceJoueurCubit.get(context)
//                                 .creerAnnonceJoueur(model: _model);
//                           }
//                         },
//                         child: BlocConsumer<AnnonceJoueurCubit,
//                             AnnonceJoueurState>(
//                           listener: (context, state) {
//                             if (state is CreerAnnonceJoueurLoadingState) {
//                               canPop = false;
//                             } else {
//                               canPop = true;
//                             }
//                             if (state is CreerAnnonceJoueurStateGood) {
//                               showToast(
//                                   msg: "annonce publier avec succes",
//                                   state: ToastStates.success);
//                               AnnonceJoueurCubit.get(context)
//                                   .getMyAnnonceJoueur(cursor: "")
//                                   .then((value) {
//                                 Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const HomeJoueur()),
//                                   (route) => false,
//                                 );
//                               });
//                             } else if (state is CreerAnnonceJoueurStateBad) {
//                               showToast(
//                                   msg: "server crashed",
//                                   state: ToastStates.error);
//                             } else if (state is ErrorStateAnnonce) {
//                               String errorMessage = state.errorModel.message!;
//                               showToast(
//                                   msg: errorMessage, state: ToastStates.error);
//                             }
//                           },
//                           builder: (context, state) {
//                             if (state is CreerAnnonceJoueurLoadingState) {
//                               return const CircularProgressIndicator();
//                             }
//                             return defaultSubmit2(
//                                 text: 'Add Annonce',
//                                 onPressed: () {
//                                   TerrainCubit.get(context).getMyreserve(
//                                       terrainId: idTerrainController.text,
//                                       date: dateTime,
//                                       heure_debut_temps: hourController.text);
//                                 });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildTimePickerField(BuildContext context,
//       TextEditingController controller, String labelText) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: labelText,
//                 prefixIcon: const Icon(Icons.access_time),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               readOnly: true,
//               onTap: () => _selectTime(context, controller),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'Please select a time'
//                   : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _selectTime(
//       BuildContext context, TextEditingController controller) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (BuildContext context, Widget? child) {
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//             child: child!,
//           );
//         });

//     if (pickedTime != null) {
//       // Format the TimeOfDay to a 24-hour format string
//       String formattedTime = _formatTimeOfDay(pickedTime);
//       controller.text = formattedTime;
//       print(controller.text);
//     }
//   }

// // Helper function to format TimeOfDay to a "HH:mm" string
//   String _formatTimeOfDay(TimeOfDay timeOfDay) {
//     final now = DateTime.now();
//     final dt = DateTime(
//         now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//     final format = DateFormat("HH:mm"); // Using 24-hour format
//     return format.format(dt);
//   }

//   Future<void> dateTimePicker(BuildContext context, DateTime dateTime) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: dateTime,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != dateTime) {
//       setState(() {
//         this.dateTime = pickedDate;
//         // print(formatDate(this.dateTime));
//       });
//     }
//   }
// }

// // Helper method to build a dropdown field with an icon
// Widget buildDropdownField({
//   required String label,
//   String? value,
//   required List<String> items,
//   required ValueChanged<String?> onChanged,
//   required IconData icon,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 6,
//           offset: Offset(0, 3),
//         ),
//       ],
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     child: DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       value: value,
//       items: items
//           .map((item) => DropdownMenuItem(
//                 value: item,
//                 child: Text(item),
//               ))
//           .toList(),
//       onChanged: onChanged,
//       validator: (value) => value == null ? 'Please select a $label' : null,
//     ),
//   );
// }
// // Helper method to build a text field with an icon

// Widget buildTextField({
//   required String label,
//   TextInputType keyboardType = TextInputType.text,
//   int maxLines = 1,
//   FormFieldSetter<String>? onChanged,
//   FormFieldValidator<String>? validator,
//   required IconData icon,
//   TextEditingController? controller,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 6,
//           offset: Offset(0, 3),
//         ),
//       ],
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       onChanged: onChanged,
//       validator: validator ??
//           (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a $label';
//             }
//             return null;
//           },
//     ),
//   );
// }
