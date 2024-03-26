import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfeprojet/Api/constApi.dart';
import 'package:pfeprojet/component/const.dart';

class Httplar {
  static Future<http.Response> httpPost(
      {required path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    var bodyEncoded = json.encode(data);
    var url = Uri.http(
      URLHTTP,
      path,
      query,
    );
    return await http.post(url, body: bodyEncoded, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $TOKEN'
    });
  }

  static Future<http.Response> httpget({
    required path,
    Map<String, dynamic>? query,
  }) async {
    var url = Uri.http(URLHTTP, path, query);
    return await http.get(url, headers: {
      'Accept': 'application/json',
      "Content-Type": "application/json",
      'Authorization': 'Bearer $TOKEN'
    });
  }

  static Future<http.Response> httpdelete(
      {required path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    var url = Uri.http(
      URLHTTP,
      path,
      query,
    );
    return await http.delete(url, body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }

  static Future<http.Response> httpPut(
      {required path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    var bodyEncoded = json.encode(data);

    var url = Uri.http(
      URLHTTP,
      path,
      query,
    );

    return await http.put(url, body: bodyEncoded, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }

  static Future<http.Response> httpPatch(
      {required path,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data}) async {
    var url = Uri.http(
      URLHTTP,
      path,
      query,
    );
    return await http.patch(url, body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
  }
}
