/* accesstoken of kakao login */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> acessTokenPost({required token}) async {

  String baseUrl = 'http://223.130.133.30:5000/api/auth/kakao/info';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), headers: {
      "Content-Type": "application/json",
      "access_toekn" : token,
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