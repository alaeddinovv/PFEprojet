import 'package:flutter/material.dart';
import 'package:pfeprojet/component/components.dart';

class AddTerrainPage extends StatefulWidget {
  const AddTerrainPage({Key? key}) : super(key: key);

  @override
  State<AddTerrainPage> createState() => _AddTerrainPageState();
}

class _AddTerrainPageState extends State<AddTerrainPage> {
  final _formKey = GlobalKey<FormState>();
  final List<NonReservableTimeBlock> nonReservableTimeBlocks = [];

  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _largeurController = TextEditingController();
  final TextEditingController _longueurController = TextEditingController();
  final TextEditingController _superficieController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _capaciteController = TextEditingController();
  final TextEditingController _etatController = TextEditingController();
  final TextEditingController _sTempsController = TextEditingController();
  final TextEditingController _eTempsController = TextEditingController();

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
    _capaciteController.dispose();
    _etatController.dispose();
    _sTempsController.dispose();
    _eTempsController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  void _addTimeBlock() async {
    final result = await showDialog<NonReservableTimeBlock>(
      context: context,
      builder: (context) => const AddTimeBlockDialog(),
    );
    if (result != null) {
      setState(() {
        nonReservableTimeBlocks.add(result);
      });
    }
  }

  void _showDeleteConfirmation(int index) async {
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
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
    if (result ?? false) {
      setState(() {
        nonReservableTimeBlocks.removeAt(index);
      });
    }
  }

  int? _editingBlockIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Terrain')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                defaultForm3(
                    controller: _adresseController,
                    labelText: 'Adresse',
                    context: context,
                    valid: () {}),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _descriptionController,
                    labelText: 'Description',
                    maxline: 3,
                    context: context,
                    valid: () {}),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _largeurController,
                    labelText: 'Largeur',
                    context: context,
                    valid: () {},
                    type: TextInputType.number),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _longueurController,
                    labelText: 'Longueur',
                    context: context,
                    valid: () {},
                    type: TextInputType.number),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _superficieController,
                    labelText: 'Superficie',
                    context: context,
                    valid: () {},
                    type: TextInputType.number),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _prixController,
                    labelText: 'Prix',
                    context: context,
                    valid: () {},
                    type: TextInputType.number),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _capaciteController,
                    labelText: 'Capacité',
                    context: context,
                    valid: () {},
                    type: TextInputType.number),
                const SizedBox(height: 10),
                defaultForm3(
                    controller: _etatController,
                    labelText: 'État',
                    context: context,
                    valid: () {}),
                const SizedBox(height: 10),
                _buildTimeRow(context),
                const SizedBox(height: 10),
                ...nonReservableTimeBlocks.asMap().entries.map((entry) {
                  int idx = entry.key;
                  NonReservableTimeBlock block = entry.value;

                  if (_editingBlockIndex == idx) {
                    // Return widgets for editing, e.g., TextFields for day and hours
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
                          controller: TextEditingController(
                              text: block.hours.join(', ')),
                          // Update hours on change
                          onChanged: (newHours) {
                            block.hours = newHours
                                .split(',')
                                .map((e) => e.trim())
                                .toList();
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.save, color: Colors.green),
                              onPressed: () => setState(() {
                                // Save changes and exit edit mode
                                _editingBlockIndex = null;
                              }),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red),
                              onPressed: () => setState(() {
                                // Exit edit mode without saving
                                _editingBlockIndex = null;
                              }),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    // Return the read-only view with edit and delete icons
                    return ListTile(
                      title: Text("${block.day}: ${block.hours.join(', ')}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => setState(() {
                              _editingBlockIndex = idx;
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmation(idx),
                          ),
                        ],
                      ),
                    );
                  }
                }).toList(),
                ElevatedButton(
                    onPressed: _addTimeBlock,
                    child: const Text('Add Time Block')),
                const SizedBox(height: 20),
                defaultSubmit2(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                    }
                  },
                  text: 'Create Terrain',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child:
              _buildTimePickerField(context, _sTempsController, 'Start Time'),
        ),
        const SizedBox(width: 10), // Adds space between the time pickers
        Expanded(
          child: _buildTimePickerField(context, _eTempsController, 'End Time'),
        ),
      ],
    );
  }

  Widget _buildTimePickerField(BuildContext context,
      TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: const Icon(Icons.access_time),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      readOnly: true,
      onTap: () => _selectTime(context, controller),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }
}

class AddTimeBlockDialog extends StatefulWidget {
  const AddTimeBlockDialog({super.key});

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
            decoration: const InputDecoration(
                hintText: 'Hours (comma-separated, e.g., 09,16)'),
            onChanged: (value) =>
                hours = value.split(',').map((e) => e.trim()).toList(),
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
              Navigator.of(context)
                  .pop(NonReservableTimeBlock(day: selectedDay!, hours: hours));
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class NonReservableTimeBlock {
  String day;
  List<String> hours;

  NonReservableTimeBlock({required this.day, required this.hours});
}
