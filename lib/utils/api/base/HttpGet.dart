import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<Map<String, dynamic>> httpGet({required String path}) async {
  String baseUrl = 'https://reqres.in$path'; //base
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;
      return resBody;

    } catch (e) {
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}