import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/screenSizeUtil.dart';

class CustomAlertDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return AlertDialog(
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
          SizedBox(height: screenHeight * 0.025),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '권한 미허용 시, 매듭 창고',
                  style: TextStyle(
                    color: Color(0xFFFF8D4D),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '를 \n사용할 수 없어요.\n',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '‘권한 설정 버튼’',
                  style: TextStyle(
                    color: Color(0xFFFF8D4D),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '을 눌러 \n',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "카메라 ",
                  style: TextStyle(
                    color: Color(0xFFFF8D4D),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '권한을 허용해주세요.',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: screenWidth * 0.045,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            ElevatedButton(
              child: Text(
                '앱 종료',
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
                exit(0); // 앱 종료
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
                '설정으로',
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              onPressed: (){
    Navigator.of(context).pop(); // 다이얼로그 닫기
    openAppSettings(); // 앱 설정 화면으로 이동
    },

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
    );
  }
}

