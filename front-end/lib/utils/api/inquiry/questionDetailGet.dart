/*
user_id로 account id 가져오는 api
*/

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<Map<String, dynamic>> QuestionDetailGet({required inquireId, required accessToken}) async {
  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/timebank-admin-service/api/admin/inquiries/$inquireId'; //base
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
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