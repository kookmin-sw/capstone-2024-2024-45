import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
로그아웃 실패했을 경우, 띄워야 하는 alert
 */

class LogoutFailAlert {
  static Future<void> showExpiredCodeDialog(
      BuildContext context, Widget retryWidget) async {

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
                  Text(
                    '사용자 정보가 올바르지 않습니다.\n 잠시후 다시 시도해주세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7D303D8),
                      fontSize: 17,
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
                          '확인',
                          style: TextStyle(
                            color: Color(0xFF2C533C),
                            fontSize: 17,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(233, 60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color(0xFFDDE9E2),
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
