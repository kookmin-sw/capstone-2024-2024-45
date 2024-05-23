/*
send x, receive o
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/screenSizeUtil.dart';

class ApiRequestFailAlert {
  static Future<void> showExpiredCodeDialog(
      BuildContext context) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 외부 터치로 닫히지 않도록 설정
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false; // true를 반환하여 AlertDialog가 닫히도록 함
            },
            child: AlertDialog(
              backgroundColor: Color(0xFFFFF6F6),
              contentPadding: EdgeInsets.all(20),
              title: Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image(
                    image: AssetImage('assets/images/timebank.png'),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '창고의 매듭이 부족해서\n"매듭 보내기"',
                          style: TextStyle(
                            color: Color(0xFF7D303D),
                            fontSize: 18,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '를 할 수 없어요!\n',
                          style: TextStyle(
                            color: Color(0xFF7D303D),
                            fontSize: 18,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '매듭이',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 18,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '0매듭 이상 ',
                          style: TextStyle(
                            color: Color(0xFF7D303D),
                            fontSize: 18,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '이어야\n"매듭 보내기"가 가능 합니다.\n',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 18,
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          '홈으로',
                          style: TextStyle(
                            color: Color(0xFF2C533C),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(115, 60),
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
                          '문의하기',
                          style: TextStyle(
                            color: Color(0xFF2C533C),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          //관리자 문의 페이지로 이동
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(115, 60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color(0xFF2C533C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
