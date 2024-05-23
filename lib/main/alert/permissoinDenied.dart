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
      backgroundColor: Colors.white,
      title: Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: Image(
            image: AssetImage('assets/images/timeBank.png'),
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
                  text: '권한 미허용 시, 시간은행',
                  style: TextStyle(
                    color: Color(0xFF7D303D),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '을 \n사용할 수 없어요.\n',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '‘권한 설정 버튼’',
                  style: TextStyle(
                    color: Color(0xFF7D303D),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '을 눌러 \n',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "카메라 ",
                  style: TextStyle(
                    color: Color(0xFF7D303D),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '권한을 허용해주세요.',
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
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  '앱 종료',
                  style: TextStyle(
                    color: Color(0xFF2C533C),
                    fontSize: 18,
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
                  fixedSize: Size(115, 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color(0xFFDDE9E2),
                ),
              ),
              ElevatedButton(
                child: Text(
                  '설정으로',
                  style: TextStyle(
                    color: Color(0xFFDDE9E2),
                    fontSize: 18,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  openAppSettings(); // 앱 설정 화면으로 이동
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(115, 60),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
    );
  }
}
