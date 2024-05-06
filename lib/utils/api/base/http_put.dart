import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';

Future<int> httpPut({required String path, Map? data}) async {
  String baseUrl = 'https://reqres.in$path';
  var body = jsonEncode(data);
  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: body, headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    return response.statusCode; //200
  } catch (e) {
    debugPrint("httpPut error: $e");
    return 503;
  }
}