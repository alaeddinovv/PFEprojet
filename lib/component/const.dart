import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/Api/httplaravel.dart';
import 'package:pfeprojet/Model/user_model.dart';
import 'package:pfeprojet/helper/cachhelper.dart';
import 'package:collection/collection.dart';

var TOKEN = '';
late final fCMToken;
var ONBOARDING = '';
Map<String, dynamic> DECODEDTOKEN = {};
Function eq = const ListEquality().equals;

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

Future<void> addOrUpdateFCMTokenAdmin(
    {required String fcmToken, required String device}) async {
  await Httplar.httpPost(
      path: ADDORUPDATETOKENFCMADMIN,
      data: {'token': fcmToken, 'device': device}).then((value) {
    print('add or update fcm token admin');
  }).catchError((e) {
    print(e.toString());
  });
}

Future<void> removeFCMTokenAdmin({required String device}) async {
  await Httplar.httpPost(path: REMOVETETOKENFCMADMIN, data: {'device': device})
      .then((value) {
    print('remove fcm token admin');
  }).catchError((e) {
    print(e.toString());
  });
}

Future<void> addOrUpdateFCMTokenJoueur(
    {required String fcmToken, required String device}) async {
  await Httplar.httpPost(
          path: ADDORUPDATETOKENFCMJoueur,
          data: {'token': fcmToken, 'device': device})
      .then((value) {})
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> removeFCMTokenJoueur({required String device}) async {
  await Httplar.httpPost(path: REMOVETETOKENFCMJoueur, data: {'device': device})
      .then((value) {})
      .catchError((e) {
    print(e.toString());
  });
}

Future<void> sendNotificationToAdmin(
    {required String title,
    required String body,
    required String adminId}) async {
  await Httplar.httpPost(
      path: SENDNOTIFICATIONTOADMIN + adminId,
      data: {'title': title, 'body': body}).then((value) {
    print('notification send successfully');
  }).catchError((e) {
    print(e.toString());
  });
}

Future<void> sendNotificationToJoueur(
    {required String title,
    required String body,
    required String joueurId}) async {
  await Httplar.httpPost(
      path: SENDNOTIFICATIONTOJOUEUR + joueurId,
      data: {'title': title, 'body': body}).then((value) {
    print('notification send successfully');
  }).catchError((e) {
    print(e.toString());
  });
}

Map<String, List<String>> findChangedJoueurs(
    List<String>? equipeJoueurs, List<String>? reservationJoueurs) {
  Set<String> set1 = equipeJoueurs?.toSet() ?? {};
  Set<String> set2 = reservationJoueurs?.toSet() ?? {};

  Set<String> deletedJoueurIds = set1.difference(set2);
  Set<String> addedJoueurIds = set2.difference(set1);

  return {
    'deleted': deletedJoueurIds.toList(),
    'added': addedJoueurIds.toList(),
  };
}
