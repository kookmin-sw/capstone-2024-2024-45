// 송금 완료 화면
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/qr/qrScanner.dart';

import '../../User/userData/User.dart';
import '../../utils/screenSizeUtil.dart';
import '../mainAccount.dart';
import 'inputTransfor.dart';

class FinishExchange extends StatefulWidget {
  const FinishExchange({super.key});

  @override
  State<FinishExchange> createState() => _FinishExchangeeState();
}

class _FinishExchangeeState extends State<FinishExchange> {
  ScannedUser scannedUser = ScannedUser();

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return WillPopScope( //뒤로가기 누를시 홈 화면으로 이동
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainAccount()));
        return false; // 화면을 떠나지 않도록 false를 반환합니다.
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '보내기 성공!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.075,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Text(
                        '매듭 보내기가',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7D303D),
                          fontSize: screenWidth * 0.1,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '완료',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF7D303D),
                              fontSize: screenWidth * 0.1,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Text(
                            ' 되었습니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: screenWidth * 0.075,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        // 패딩 설정
                        child: SizedBox(
                          height: screenWidth * 0.5,
                          width: screenWidth * 0.5,
                          child: Lottie.asset("assets/lottie/handshake.json"),
                        ),
                      ),
                      Text(
                        '추가로 보낼까요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: screenWidth * 0.075,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(height: screenHeight * 0.025),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => qrScanner()),
                    );
                  },
                  child: Text(
                    '예, 추가로 매듭을 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDDE9E2),
                      fontSize: screenWidth * 0.055,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF2C533C),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainAccount()));
                  },
                  child: Text(
                    '아니요, 매듭을 그만 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff2C533C),
                      fontSize: screenWidth * 0.055,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFFDDE9E2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

