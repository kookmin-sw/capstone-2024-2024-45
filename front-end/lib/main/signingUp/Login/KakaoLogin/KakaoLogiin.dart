import 'package:flutter/cupertino.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/login_out.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

import 'package:flutter/services.dart';
import 'package:suntown/utils/api/connect/loginAuthPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import '../../../../utils/api/connect/accessTokenPost.dart';

class KakaoLogin implements SocialLogin {
  String accessToken = "";

  Future<void> AuthKakaoToken(String accessToken) async {
    try {
      final value = await loginAuthPost(token: accessToken);
      if (value["statusCode"] == 200) {
        print('Auth 서버에 무사히 접속');
        print(value);
      } else if (value["statusCode"] == 400) {
        print(value);
        debugPrint('AuthKakaoToken 에러입니다. 다시 시도해주세요');
      } else {
        print(value);
        debugPrint('AuthKakaoToken 에러입니다. 다시 시도해주세요');
        print(value['message']);
        throw Exception('서버 에러입니다. 다시 시도해주세요: ${value["statusCode"]} - ${value["message"]}');
      }
    } catch (e, stackTrace) {
      print('AuthKakaoToken 에러------------');
      print('Exception: $e');
      print('Stack trace: $stackTrace');
      // 더 자세한 정보를 확인하기 위해 throw를 사용하여 다시 Exception을 발생시킴
      throw e;
    }
  }


  @override
  Future<bool> login() async {
    try{
      // 카카오톡 설치 여부 확인
      bool isInstalled = await kakao.isKakaoTalkInstalled();

      if (isInstalled){
        // 카카오톡 설치 되어 있으면 진행
        try {
          kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoTalk();
          // Access Token 추출
          // Map<String, dynamic> jsonResponseMap = jsonDecode(response.body);
          // String accessToken = jsonResponseMap['access_token'];
          String accessToken = token.accessToken;
          print('accessToken------------$accessToken');
          AuthKakaoToken(accessToken);
          return true;
        } catch(e) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (e is PlatformException && e.code == 'CANCELED') {
            print('카카오톡으로 로그인 실패 $e');
          }
          // 카카오톡에 연결된 카카오 계정이 없는 경우, 카카오계정으로 로그인.
          try{
            kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoAccount();
            String accessToken = token.accessToken;
            print('accessToken------------$accessToken');
            AuthKakaoToken(accessToken);

          }catch (e){
            print("카카오 로그인 실패 $e");
          }
        }
      } else {
        // 카톡 설치 안되어있으면 카카오 계정으로 진행
        try {
          kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoAccount();
          String accessToken = token.accessToken;
          print('accessToken------------$accessToken');
          AuthKakaoToken(accessToken);

          return true;
        } catch(e){
          print('카카오계정으로 로그인 실패 $e');
        }
      }
      return true;
    }catch(e){
      return false;
    }
  }
  @override
  Future<bool> logout() async {
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    }catch (error){
      return false;
    }
  }
}
