import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:suntown/main/mainAccount.dart';

import '../../utils/screenSizeUtil.dart';

/*
미완_api 요청 실패했을 경우, 띄워야 하는 alert
 */

class ApiRequestFailAlert {
  static Future<void> showExpiredCodeDialog(
      BuildContext context) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false; // true를 반환하여 AlertDialog가 닫히도록 함
            },
            child: AlertDialog(
              backgroundColor: Color(0xFFFFF6F6),
              contentPadding: EdgeInsets.all(20),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("임시")
                ],
              ),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                      child: const Text(
                        '홈으로',
                        style: TextStyle(
                          color: Color(0xFFFFF6F6),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        // 메인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainAccount()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth*0.3, screenHeight*0.07),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFF4B4A48),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}