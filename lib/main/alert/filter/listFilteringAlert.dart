import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/screenSizeUtil.dart';

class listFilteringAlert {
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
              contentPadding: EdgeInsets.all(20),
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "어떤걸 볼까요?",
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: screenWidth * 0.06,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
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
                    height: screenHeight * 0.005,
                  ),
                  Container(
                    height: 1.0,
                    width: screenWidth * 1.0,
                    color: Color(0xff624A43),
                  ),
                ],
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Column(
                  children: [
                    ElevatedButton(
                      child: Text(
                        '주고받은 매듭 확인하기',
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        updateTypeCallback("ALL", "전체");
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.8, screenHeight * 0.07),
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
                        '보낸 매듭 확인하기',
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        updateTypeCallback("SEND", "보낸 매듭");
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.8, screenHeight * 0.07),
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
                        '받은 매듭 확인하기',
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        updateTypeCallback("RECEIVE", "받은 매듭");
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.8, screenHeight * 0.07),
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
              ]),
            ),
          );
        });
  }
}
