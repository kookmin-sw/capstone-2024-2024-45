import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/screenSizeUtil.dart';

class chooseMinutes {
  static Future<void> showExpiredCodeDialog(BuildContext context, FocusNode inputNode,  {required void Function(String)? onValueSelected}) async {
    // 포커스 해제
    FocusScope.of(context).unfocus();
    {
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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                title: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "몇분을 추가할까요?",
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 20,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close), // X 아이콘
                            iconSize: 30, // 아이콘의 크기를 설정합니다.
                            onPressed: () {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
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
                content: SizedBox(
                  width: 300,
                  height: 150,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text(
                              '30분',
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 30,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              onValueSelected?.call('30');
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(250, 60),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
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
                            height: 10,
                          ),
                          ElevatedButton(
                            child: Text(
                              '00분',
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 30,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              onValueSelected?.call('00');
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(250, 60),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: Color(0xFFD3C2BD),
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          });
    }
  }
}
