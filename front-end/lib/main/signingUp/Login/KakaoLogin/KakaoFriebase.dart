import 'package:suntown/main/signingUp/Login/KakaoLogin/login_out.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:suntown/main/defaultAccount.dart';

class KakaoLogin implements SocialLogin {
  String accessToken = "";
  final url = Uri.https('kapi.kakao.com', '/v2/user/me');

  final BuildContext context;

  KakaoLogin(this.context);

  @override
  Future<bool> login() async {
    try {
      // 카카오톡 설치 여부 확인
      bool isInstalled = await kakao.isKakaoTalkInstalled();

      if (isInstalled) {
        // 카카오톡 설치 되어 있으면 진행
        try {
          kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoTalk();
          var provider = auth.OAuthProvider('oidc.kakao'); // 제공업체 id
          var credential = provider.credential(
            idToken: token.idToken,
            accessToken: token.accessToken, // 카카오 로그인에서 발급된 accessToken
          );
          await auth.FirebaseAuth.instance.signInWithCredential(credential);

          print('Access Token: ${token.accessToken}');

          // 로그인 성공시 defaultAccount로 이동
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => defaultAccount()),
            );
          }
          return true;
        } catch (e) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (e is PlatformException && e.code == 'CANCELED') {
            print('카카오톡으로 로그인 실패 $e');
          } else {
            // 카카오톡에 연결된 카카오 계정이 없는 경우, 카카오계정으로 로그인.
            try {
              kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoAccount();
              var provider = auth.OAuthProvider('oidc.kakao');
              var credential = provider.credential(
                idToken: token.idToken,
                accessToken: token.accessToken,
              );
              await auth.FirebaseAuth.instance.signInWithCredential(credential);

              // 로그인 성공시 defaultAccount로 이동
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => defaultAccount()),
                );
              }
              return true;
            } catch (e) {
              print("카카오 로그인 실패 $e");
              return false;
            }
          }
        }
      } else {
        // 카톡 설치 안되어있으면 카카오 계정으로 진행
        try {
          kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoAccount();
          var provider = auth.OAuthProvider('oidc.kakao');
          var credential = provider.credential(
            idToken: token.idToken,
            accessToken: token.accessToken,
          );
          await auth.FirebaseAuth.instance.signInWithCredential(credential);

          // 로그인 성공시 defaultAccount로 이동
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => defaultAccount()),
            );
          }
          return true;
        } catch (e) {
          print('카카오계정으로 로그인 실패 $e');
          return false;
        }
      }
      return false;
    } catch (e) {
      print('카카오 로그인 실패 $e');
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    } catch (error) {
      print('카카오 로그아웃 실패 $error');
      return false;
    }
  }
}
