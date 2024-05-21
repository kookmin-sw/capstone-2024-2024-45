import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:suntown/utils/api/connect/loginAuthPost.dart';

class KakaoAuthService {
  final String clientId;
  final String redirectUri;

  KakaoAuthService({required this.clientId, required this.redirectUri});

  Future<String?> requestAuthorizationUrl() async {
    print('requestAuthorizationUrl 실행 중------');
    final String authorizationUrl =
        'https://kauth.kakao.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code';
    print('-----------------');
    print(authorizationUrl);
    try {
      final http.Response response = await http.get(Uri.parse(authorizationUrl));
      if (response.statusCode == 200) {
        return authorizationUrl;
      } else {
        print('Failed to request authorization code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error requesting authorization code: $error');
      return null;
    }
  }

  Future<String> fetchKakaoToken(String code) async {
    await dotenv.load();

    final response = await http.post(
      Uri.parse('https://kauth.kakao.com/oauth/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
      },
      body: {
        'grant_type': 'authorization_code',
        'client_id': dotenv.env['KAKAO_REST_API_KEY']!,
        'redirect_uri': dotenv.env['KAKAO_REDIRECT_URI']!,
        'code': code,
        'client_secret': dotenv.env['KAKAO_CLIENT_SECRET']!,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponseMap = jsonDecode(response.body);
      String accessToken = jsonResponseMap['access_token'];
      print('accessToken------------$accessToken');
      return accessToken;
    } else {
      print('Failed to fetch token: ${response.statusCode}');
      throw Exception('Failed to fetch token');
    }
  }

  Future<void> getCodeAndSendToServer() async {
    Uri uri = Uri.parse(redirectUri);
    String? code = uri.queryParameters['code'];
    if (code == null) {
      print("Error: code is null");
      return;
    }
    print("-------------------");
    print(code);

    try {
      String accessToken = await fetchKakaoToken(code);
      final value = await loginAuthPost(token: accessToken);
      if (value["statusCode"] == 200) {
        print('login 서버에 무사히 접속');
        print(value);
      } else if (value["statusCode"] == 400) {
        print(value);
        debugPrint('loginAuthPost서버 에러입니다. 다시 시도해주세요');
      } else {
        print(value);
        debugPrint('loginAuthPost서버 에러입니다. 다시 시도해주세요');
        print(value['message']);
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      print('fetchKakaoToken 에러------------');
      print(e);
    }
  }
}
