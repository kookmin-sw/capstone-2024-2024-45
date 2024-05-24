import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/screenSizeUtil.dart';

class AskStateFilter {
  static Future<void> showExpiredCodeDialog(BuildContext context,
      {required Function(String, String) updateTypeCallback} // 콜백 함수 추가
      ) async {
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
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              title: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "상태",
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: 25,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close), // X 아이콘
                            onPressed: () {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1.0,
                    width: 250, //고정값으로 변경..
                    color: Color(0xff624A43),
                  ),
                ],
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          '모두 보기',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          updateTypeCallback("ALL", "모두 보기");
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(250,60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Color(0xFFD3C2BD),
                              width: 1.0, // 선 굵기
                            ), // 선 추가
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      ElevatedButton(
                        child: Text(
                          '등록',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          updateTypeCallback("SEND", "등록");
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(250,60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Color(0xFFD3C2BD),
                              width: 1.0,
                            ),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      ElevatedButton(
                        child: Text(
                          '기다리는 중',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          updateTypeCallback("RECEIVE", "기다리는 중");
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(250,60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Color(0xFFD3C2BD),
                              width: 1.0,
                            ), // 선 추가
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      ElevatedButton(
                        child: Text(
                          '해결완료',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          updateTypeCallback("RECEIVE", "완료");
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(250,60),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Color(0xFFD3C2BD),
                              width: 1.0,
                            ), // 선 추가
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
