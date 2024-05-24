/* connect user account */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> userAccoPost({required user_id, required account_id, required name}) async {

  String baseUrl = 'http://223.130.133.30:8000/api/user/$user_id/account';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "account_id": account_id,
      "name": name,
      "permission": "rw",
    }), headers: {
      "Content-Type": "application/json",
      "user_id" : user_id,
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
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