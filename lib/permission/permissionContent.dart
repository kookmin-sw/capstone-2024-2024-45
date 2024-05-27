import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/permission/permissionNotifier.dart';

import '../utils/api/connect/tokenRefreashPost.dart';
import '../utils/api/connect/tokenReissuePost.dart';
import '../utils/screenSizeUtil.dart';

import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:suntown/main/defaultAccount.dart';


class PermissionContent extends StatefulWidget {
  @override
  State<PermissionContent> createState() => _PermissionContentState();
}

class _PermissionContentState extends State<PermissionContent> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //지금 이 세션관리 메서드들은..차후 따로 뺄 예정
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    final provider = Provider.of<PermissionNotifier>(context, listen: false);
    bool isAgree = provider.isPermissionGranted;
    // 위젯을 빌드할 때마다 권한 상태를 업데이트
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        provider.checkAndUpdatePermissionStatusFromSettings();
        isAgree = provider.isPermissionGranted;
      });
    });

    return Container(
      child: Expanded(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.47,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFD3C2BD)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      child: Image(
                        image: AssetImage('assets/images/knot.png'),
                      ),
                    ),
                    Text(
                      "카메라",
                      style: TextStyle(
                        color: Color(0xff4B4A48),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ]),
                  Divider(
                    thickness: 1,
                    color: Color(0xffD3C2BD),
                  ),
                  Text(
                    '“시간은행” 송금을 진행 하려면,\n타임 코드를 카메라로 스캔해야 합니다.\n이를 위해 카메라 권한이 필요합니다.',
                    style: TextStyle(
                      color: Color(0xff4B4A48),
                      fontSize: 17,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      child: Image(
                        image: AssetImage('assets/images/knot.png'),
                      ),
                    ),
                  ]
                ),
                SizedBox(
                  width: screenWidth * 0.03
                  ,
                ),
                Text(
                  '권한 허용 후, 시간은행을 시작합니다.\n아래 “권한 설정하기” 버튼을 눌러서\n권한을 허용해주세요',
                  style: TextStyle(
                    color: Color(0xFF727272),
                    fontSize: 17,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
                ),
              ],
            ),
            Spacer(),
            !isAgree
                ? ElevatedButton(
                    onPressed: () {
                      provider.requestCameraPermission(context);
                      // 상태를 업데이트하고 버튼 텍스트를 변경
                      setState(() {});
                    },
                    child: const Text(
                      '권한 설정',
                      style: TextStyle(
                        color: Color(0xffDDE9E2),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF2C533C),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
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
                    },
                    child: const Text(
                      '앱 시작하기',
                      style: TextStyle(
                        color: Color(0xFF2C533C),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFFDDE9E2),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
