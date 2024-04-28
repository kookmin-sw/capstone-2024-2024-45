import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suntown/main/Exchange/inputTransfor.dart';
import 'package:suntown/qr/qrScanner.dart';
import 'package:suntown/utils/screenSizeUtil.dart';

import '../../User/User.dart';

User userData = User();

/*
dialog 추가된 것, 캡스톤에 옮기기, 그리고 exchange 부분 변경사항 변경하기
 */

class CorrectAlertDialog {
  static Future<void> show(BuildContext context) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFFFFF6F6),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          height: screenHeight * 0.6,
          width: screenWidth,
          child: Column(
            children: <Widget>[
              Text(
                "\u{1F440}",
                style: TextStyle(
                    fontSize: screenWidth * 0.075,
                    fontFamily: 'Noto Sans KR'
                ),
              ),
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "매듭을 잘못 입력하셨거나",
                      style: TextStyle(
                        color: Color(0xFF727272),
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text("스캔을 잘못하셨나요?",
                      style: TextStyle(
                        color: Color(0xFF727272),
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    Text("어디로 이동할까요?",
                      style: TextStyle(
                        color: Color(0xFFFF8D4D),
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),)
                  ],
                ),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => qrScanner()));
                    },
                    child: Text(
                      '매듭 코드 스캔으로 돌아갑니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: screenWidth * 0.055,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFFFFD852),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  InputTransfor(userId: userData.id)));
                    },
                    child: Text(
                      '보낼 매듭 입력으로 돌아갑니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: screenWidth * 0.055,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFFFF8D4D),
                    ),
                  ),
                  SizedBox(
                    height : screenHeight * 0.025,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '"매듭 보내기"를 계속합니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.055,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF4B4A48),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
