import 'package:flutter/material.dart';

class AddAnnonceScreen extends StatefulWidget {
  @override
  _AddAnnonceScreenState createState() => _AddAnnonceScreenState();
}

class _AddAnnonceScreenState extends State<AddAnnonceScreen> {
  String _selectedType = 'search joueur'; // Default selected type
  int _selectedNumeroJoueurs = 1; // Default selected number of joueurs
  List<String> _selectedPostWants = [
    'attaquant'
  ]; // Default selected post wants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Annonce'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: ['search joueur', 'search join equipe', 'other']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Type',
              ),
            ),
            if (_selectedType == 'search joueur') ...[
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _selectedNumeroJoueurs.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _selectedNumeroJoueurs = int.tryParse(value) ?? 1;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Number of Joueurs',
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedPostWants.first,
                items: ['attaquant', 'defenseur', 'gardia', 'milieu']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPostWants = [newValue!];
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Post Wants',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Add another Post Want: '),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _selectedPostWants.add('attaquant');
                      });
                    },
                  ),
                ],
              ),
            ],
            // Add more fields based on other types if needed
            // For example:
            // if (_selectedType == 'search join equipe') ...[ ... ],
            // if (_selectedType == 'other') ...[ ... ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic to save the annonce
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
