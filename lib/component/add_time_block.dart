import 'package:flutter/material.dart';
import 'package:pfeprojet/Model/terrain_model.dart';
import 'package:pfeprojet/component/const.dart';

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
