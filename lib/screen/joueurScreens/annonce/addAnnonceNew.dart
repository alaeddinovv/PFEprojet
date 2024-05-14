import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';

class AddAnnoncePage extends StatefulWidget {
  @override
  _AddAnnoncePageState createState() => _AddAnnoncePageState();
}

class _AddAnnoncePageState extends State<AddAnnoncePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  int? _numeroJoueurs;
  final List<String> _positions = [
    'attaquant',
    'defenseur',
    'gardia',
    'milieu'
  ];
  List<String?> _selectedPositions = [];
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Annonce'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get the width of the screen
          double width = constraints.maxWidth;
          // Adjust padding based on screen width
          double padding = width > 600 ? 32.0 : 16.0;
          // Set a fixed width for larger screens
          double fieldWidth = width > 600 ? 500.0 : double.infinity;

          return Center(
            child: Container(
              width: fieldWidth,
              padding: EdgeInsets.all(padding),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Dropdown field for selecting the type of annonce
                    buildDropdownField(
                      label: 'Type',
                      value: _selectedType,
                      items: ['search joueur', 'search join equipe', 'other'],
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                      icon: Icons.category,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedType == 'search joueur') ...[
                      // Text field for entering the number of players
                      buildTextField(
                        label: 'Number of Players',
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
                              _errorMessage =
                                  'Number of players cannot exceed 5';
                            }
                          });
                        },
                        icon: Icons.people,
                      ),
                      // Display error message if number of players exceeds 5
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      // Dropdown fields for selecting positions for each player
                      for (int i = 0; i < (_numeroJoueurs ?? 0); i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: buildDropdownField(
                            label: 'Position for Player ${i + 1}',
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
                    // Text field for entering the description
                    buildTextField(
                      label: 'Description',
                      maxLines: 3,
                      icon: Icons.description,
                    ),
                    const SizedBox(height: 20),
                    // Submit button
                    defaultSubmit2(
                      text: 'Add Annonce',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Helper method to build a dropdown field with an icon
Widget buildDropdownField({
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
      boxShadow: [
        const BoxShadow(
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
      validator: (value) => value == null ? 'Please select a $label' : null,
    ),
  );
}

// Helper method to build a text field with an icon
Widget buildTextField({
  required String label,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  FormFieldSetter<String>? onChanged,
  FormFieldValidator<String>? validator,
  required IconData icon,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        const BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: TextFormField(
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
              return 'Please enter a $label';
            }
            return null;
          },
    ),
  );
}
