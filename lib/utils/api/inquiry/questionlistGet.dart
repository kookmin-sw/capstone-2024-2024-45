/*
user_id로 account id 가져오는 api
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<Map<String, dynamic>> QuestionListGet({required user_id}) async {
  String baseUrl = 'http://223.130.154.131:80/api/admin/inquiries'; //base
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
      "userId" : user_id,
    });
    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;
      return resBody;

    } catch (e) {
      return {'statusCode': 422};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}