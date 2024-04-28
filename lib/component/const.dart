import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var TOKEN = '';
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};

String? formatTimeOfDay(TimeOfDay? time) {
  if (time == null) return null;
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

String? formatDate(DateTime? date) {
  if (date == null) return null;
  return DateFormat('yyyy-MM-dd').format(date);
}

String normalizeTimeInput(String input) {
  try {
    // Replace dots with colons and handle inputs like "9.30"
    input = input.replaceAll('.', ':');

    // Append ":00" if input is only an hour without minutes
    if (!input.contains(':') && int.tryParse(input) != null) {
      input += ":00";
    }

    // Use DateFormat to parse and reformat the time
    DateTime parsedTime = DateFormat("Hm").parseLoose(input);
    return DateFormat("HH:mm").format(parsedTime);
  } catch (e) {
    print('Error parsing time: $e');
    // Return null or an invalid time string to indicate failure
    return "Invalid Time";
  }
}
