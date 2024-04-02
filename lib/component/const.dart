import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Model/terrain_model.dart';

var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};
List<DateTime> getNextSevenDays() {
  return List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
}
// List<String> getTimeSlots(TerrainModel terrain) {
//   List<String> slots = [];
//   // Assuming s_temps and e_temps are Strings like "08:00", convert them to DateTime
//   DateTime start = DateFormat('HH:mm').parse(terrain.sTemps!);
//   DateTime end = DateFormat('HH:mm').parse(terrain.eTemps!);
//   // Assuming nonReservableTimeBlocks contains a list of hours as strings ["09", "16"]
//   List<dynamic> nonReservableHours = terrain.nonReservableTimeBlocks!
//       .where((block) => block.day == DateFormat('EEEE').format(selectedDate)) // Filter by selected day
//       .map((block) => block.hours)
//       .expand((i) => i)
//       .toList();

//   while(start.isBefore(end)) {
//     String hour = DateFormat('HH').format(start);
//     if (!nonReservableHours.contains(hour)) {
//       slots.add(DateFormat('HH:mm').format(start));
//     }
//     start = start.add(Duration(hours: 1)); // Increment by one hour
//   }

//   return slots;
// }


// final List<DateTime> dates = List.generate(
//   7,
//   (index) => DateTime.now().add(
//     Duration(days: index),
//   ),
// );
// String formatWeekdayDate(DateTime dateTime) {
//   // These arrays represent the weekdays and months in French.
//   const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
//   const months = [
//     'Jan',
//     'Fév',
//     'Mar',
//     'Avr',
//     'Mai',
//     'Jun',
//     'Jul',
//     'Aoû',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Déc'
//   ];

//   // Get the weekday and month as a string.
//   String weekday = weekdays[dateTime.weekday - 1];
//   String month = months[dateTime.month - 1];

//   // Return the formatted date.
//   return '$weekday, ${dateTime.day} $month';
// }

// Future<void> selectDate(
//     BuildContext context, TextEditingController dateController) async {
//   DateTime? _picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2025),
//   );
//   if (_picked != null) {
//     dateController.text = _picked.toString();
//   }
// }
