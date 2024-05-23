import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

Future<Map<String, dynamic>> userInfoGet({required int otherUserId, required String userId}) async {
  String url = dotenv.env['USER_PROFILE_URL']!;
  String baseUrl = '${url}/haetsal-service/api/v2/profile';

  // otherUserId를 쿼리 파라미터로 추가
  var params = {'otherUserId': otherUserId.toString()};

  try {
    // 쿼리 파라미터를 URL에 추가
    url = Uri.http(url, '$baseUrl', params).toString();

    http.Response response = await http.get(Uri.parse(url), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
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
