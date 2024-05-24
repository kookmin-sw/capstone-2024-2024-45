import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

Future<Map<String, dynamic>> tokenRefreshPost({required String refreshToken}) async {
  String REST_API_KEY = "1a354a3d4dc989747906944c3c188196";
  String USER_REFRESH_TOKEN = refreshToken;

  // 요청 URL
  String url = 'https://kauth.kakao.com/oauth/token';

  // 요청 바디 데이터
  var body = {
    'grant_type': 'refresh_token',
    'client_id': REST_API_KEY,
    'refresh_token': USER_REFRESH_TOKEN,
  };

  try {
    // POST 요청 보내기
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    // 응답 확인
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    try{
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;

      print("-----------응답....------------");
      print(resBody);
      return resBody;
    }catch (e){
      print(e);
      return {'statusCode': 490};
    }
  } catch (e) {
    print('Error: $e');
    return {'statusCode': 503};
  }
}
