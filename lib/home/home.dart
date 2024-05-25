import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:suntown/utils/api/connect/tokenRefreashPost.dart';
import 'package:suntown/utils/api/connect/tokenReissuePost.dart';

import '../permission/permissionWidget.dart';
import '../utils/screenSizeUtil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final page = const MainAccount();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      checkPermissionsAndNavigate();
    });
  }
  // 권한 허용 확인
  Future<void> checkPermissionsAndNavigate() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (cameraPermissionStatus.isGranted) { // 카메라 권한이 설정 되어있는지 확인
      _checkLoginStatus();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PermissionWidget()));
    }
  }

  // 로그인 상태 확인
  Future<void> _checkLoginStatus() async {
    final refreshToken = await secureStorage.read(key: 'refreshToken');
    print('refreshToken--------$refreshToken');
    if (refreshToken != null) {
      final state = await tokenRefreash(refreshToken:refreshToken);
      // if(state){ // accessToken 재발급 받은 경우
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => defaultAccount()),
      //   );
      // }
      // else{ // accessToken 재발급 실패한 경우
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => signingUP()),
      //   );
      // }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signingUP()),
      );
    } else { // 로그인 안되어 있는 경우
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signingUP()),
      );
    }
  }

  // json에서 값 가져오는 함수
  Map<String, String?> parseTokens(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return {
      'access_token': parsed['access_token'],
      'refresh_token': parsed['refresh_token'],
    };
  }

  // refreash 토큰으로 카카오에 accesstoken 다시 요청하기 - 섹션관리
  Future<bool> tokenRefreash({required String refreshToken}) async {
    try { // 카카오에 Refresh 토큰으로 access token 요청하기
      final value = await tokenRefreshPost(refreshToken: refreshToken);
      if (value['statusCode'] == 200) { // 성공적으로 토큰을 받은 경우
        Map<String, dynamic> tokens = parseTokens(value['body']);
        // 새로운 토큰 저장
        print('새로 받아온 카카오 토큰 --------- \n $tokens');
        await secureStorage.write(key: 'refreshToken', value: tokens['refresh_token']);
        await secureStorage.write(key: 'accessToken', value: tokens['access_token']);
        try { // 우리 서버에 갱신한 토큰 보내기
          final state = await tokenReissuePost(accessToken: tokens['access_token'], refreshToken: tokens['refresh_token']);
          if (state['statusCode'] == 200) { // 서버에 문제없이 잘 도착한 경우
            return true;
          } else { // 서버에 문제가 있는 경우
            print('서버에 문제가 있는 경우 --- $state');
          }
        } catch (e) {// 서버 요청 중 오류가 발생한 경우
          print("tokenReissuePost 서버 요청 중 오류가 발생");
          print(e);
        }
      } else { // Refresh token이 만료된 경우
        print('Refresh token 만료, 재 로그인이 필요합니다.');
      }
    } catch (error) { // 요청 중 오류가 발생한 경우
      print("tokenRefreashPost 서버 요청 중 오류가 발생");
      print(error);
    }
    return false;
  }

  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFFDF3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image(
                    image: AssetImage('assets/images/timebank.png'),
                  ),
                ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
            ]
            )
          ),
        ],
      ),
    );
  }
}