import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> userInfoPost({required oauth_id, required mobile_number, required name, required nickname, required image_url}) async {

  String baseUrl = 'http://223.130.133.30:8000/api/user/$oauth_id';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "mobile_number": mobile_number,
      "name": name,
      "gender": "female",
      "profile_info": {
        "nickname": nickname,
        "image_url" : image_url
      }
    }), headers: {
      "Content-Type": "application/json",
      "oauth_id" : oauth_id, //예시 oauth_id
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