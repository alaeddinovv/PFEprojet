import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var TOKEN = '';
late final fCMToken;
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

Future<String> getDeviceIdentifier() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

  String deviceInfo = '${androidInfo.model}(${androidInfo.id})';
  await CachHelper.putcache(key: 'deviceInfo', value: deviceInfo);
  return deviceInfo;
}

Future<void> updateDeviceToken(String fcmToken) async {
  try {
    String deviceId = await getDeviceIdentifier();

    addOrUpdateToken(fcmToken, deviceId);
  } catch (e) {
    print("Failed to get device identifier: $e");
  }
}

Future<void> addOrUpdateToken(String fcmToken, String device) async {
  const String apiUrl = 'http://localhost:3000/api/addOrUpdateTokenAdmin';
  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $TOKEN'
      },
      body: jsonEncode({
        'fcmToken': fcmToken,
        'device': device,
      }),
    );

    if (response.statusCode == 200) {
      print("FCM Token updated successfully");
    } else {
      print("Failed to update FCM Token: ${response.body}");
    }
  } catch (e) {
    print("Error when updating FCM Token: $e");
  }
}

Future<void> removeToken(String joueurId, String device) async {
  const String apiUrl = 'https://your-api-url.com/api/joueur/remove-token';
  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'joueurId': joueurId,
        'device': device,
      }),
    );
    if (response.statusCode == 200) {
      print("FCM Token removed successfully");
    } else {
      print("Failed to remove FCM Token: ${response.body}");
    }
  } catch (e) {
    print("Error when removing FCM Token: $e");
  }
}
