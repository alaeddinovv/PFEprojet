import 'package:flutter/material.dart';

var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};

final List<DateTime> dates = List.generate(
  7,
  (index) => DateTime.now().add(
    Duration(days: index),
  ),
);
String formatWeekdayDate(DateTime dateTime) {
  // These arrays represent the weekdays and months in French.
  const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  const months = [
    'Jan',
    'Fév',
    'Mar',
    'Avr',
    'Mai',
    'Jun',
    'Jul',
    'Aoû',
    'Sep',
    'Oct',
    'Nov',
    'Déc'
  ];

  // Get the weekday and month as a string.
  String weekday = weekdays[dateTime.weekday - 1];
  String month = months[dateTime.month - 1];

  // Return the formatted date.
  return '$weekday, ${dateTime.day} $month';
}

Future<void> selectDate(
    BuildContext context, TextEditingController dateController) async {
  DateTime? _picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (_picked != null) {
    dateController.text = _picked.toString();
  }
}
