import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suntown/main/Exchange/inputTransfor.dart';
import 'package:suntown/qr/qrScanner.dart';
import 'package:suntown/utils/screenSizeUtil.dart';

import '../../User/userData/User.dart';

class CorrectAlertDialog {
  static Future<void> show(BuildContext context) async {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      isDismissible: false, // ModalBottomSheet 외부 터치로 닫히지 않도록 설정
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          height: screenHeight * 0.65,
          width: screenWidth,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  image: AssetImage('assets/images/knot.png'),
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
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text("스캔을 잘못하셨나요?",
                      style: TextStyle(
                        color: Color(0xFF727272),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    Text("어디로 이동할까요?",
                      style: TextStyle(
                        color: Color(0xFF7D303D),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),)
                  ],
                ),
              ),
              Spacer(),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          color: Color(0xFFDDE9E2),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFF2C533C),
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
                                    InputTransfor()));
                      },
                      child: Text(
                        '보낼 매듭 입력으로 돌아갑니다',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2C533C),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFFDDE9E2),
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
                          color: Color(0xff624A43),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth*0.9, screenHeight*0.08),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFFD0BAAD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
