import 'package:flutter/material.dart';
import 'package:suntown/main/mainAccount.dart';

import '../../utils/screenSizeUtil.dart';

class QrTimeOutDialog {
  static Future<void> showExpiredCodeDialog(
      BuildContext context, Function() onRetry) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 외부 터치로 닫히지 않도록 설정
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              onRetry();
              return true; // true를 반환하여 AlertDialog가 닫히도록 함
            },
            child: AlertDialog(
              backgroundColor: Color(0xFFFFF6F6),
              contentPadding: EdgeInsets.all(20),
              title: Center(
                child: Text("\u{1F62D}",
                  style: TextStyle(
                    color: Color(0xFFFF8D4D),
                    fontSize: screenWidth * 0.075,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenHeight * 0.025
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '유효기간',
                          style: TextStyle(
                            color: Color(0xFFFF8D4D),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '이 지난 코드에요!\n',
                          style: TextStyle(
                            color: Color(0xFFFF8D4D),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '다른 코드를 스캔하려면\n',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '"다시스캔하기"를\n',
                          style: TextStyle(
                            color: Color(0xFFFF8D4D),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '홈으로 돌아가려면\n',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '"홈으로"를 눌러주세요',
                          style: TextStyle(
                            color: Color(0xFFFF8D4D),
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                      child: Text(
                        '홈으로',
                        style: TextStyle(
                          color: Color(0xFFFFF6F6),
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
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
                    ElevatedButton(
                      child: Text(
                        '다시스캔',
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth*0.3, screenHeight*0.07),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFFFFD852),
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
