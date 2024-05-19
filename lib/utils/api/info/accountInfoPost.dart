import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> accountInfoPost({required password, required username, required mobile_number, required user_id, required account_name}) async {

  String baseUrl = 'http://223.130.133.30:8080/api/accounts/register';
  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "type" : "User",
      "password": password,
      "username": username,
      "mobile_number": mobile_number,
      "user_id" : user_id,
      "account_name" : account_name
    }), headers: {
      "Content-Type": "application/json",
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      print('-----');
      print(response.statusCode);
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