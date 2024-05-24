// 송금 완료 화면
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/qr/qrScanner.dart';

import '../../utils/screenSizeUtil.dart';
import '../mainAccount.dart';

class FinishExchange extends StatefulWidget {
  const FinishExchange({super.key});

  @override
  State<FinishExchange> createState() => _FinishExchangeeState();
}

class _FinishExchangeeState extends State<FinishExchange> {

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
                          fontSize: 30,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Text(
                        '시간 보내기가',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7D303D),
                          fontSize: 30,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
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
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ' 되었습니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        // 패딩 설정
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Lottie.asset("assets/lottie/handshake.json"),
                        ),
                      ),
                      Text(
                        '추가로 보낼까요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 30,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
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
                    '예, 추가로 시간을 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDDE9E2),
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
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
                    '아니요, 시간을 그만 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff2C533C),
                      fontSize: 20,
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

