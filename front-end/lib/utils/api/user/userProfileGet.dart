import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

Future<Map<String, dynamic>> userProfileGet({required String userId,required String accessToken}) async {
  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/haetsal-service/api/v2/profile';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // JWT 토큰을 헤더에 추가
    });
  print('jwt 값 잘 들어갔나 확인 ------ \n "Bearer $accessToken"');
  // print('userID -------$userId');
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
