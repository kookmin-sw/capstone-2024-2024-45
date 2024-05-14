import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suntown/main/defaultAccount.dart';

import '../../../utils/screenSizeUtil.dart';

/*
미완_api 요청 실패했을 경우, 띄워야 하는 alert
 */

class accountCreateFail {
  static Future<void> showExpiredCodeDialog(
      BuildContext context, Widget retryWidget) async {
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
                    image: AssetImage('assets/images/knot.png'),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '계좌 만들기에 문제가 발생했습니다.\n다시 시도 해주세요!',
                    style: TextStyle(
                      color: Color(0xFF7D303D8),
                      fontSize: 18,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                    ),
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
                            fontSize: 17,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                          // 메인 화면으로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => defaultAccount()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(115, 60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color(0xFFDDE9E2),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          '다시시도',
                          style: TextStyle(
                            color: Color(0xFFDDE9E2),
                            fontSize: 17,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                          // 메인 화면으로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => retryWidget),
                          );
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
