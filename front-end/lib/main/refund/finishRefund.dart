// 송금 완료 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/qr/qrScanner.dart';

import '../../User/refundUserData/RefundUser.dart';
import '../../utils/screenSizeUtil.dart';
import '../mainAccount.dart';

class FinishRefund extends StatefulWidget {
  const FinishRefund({super.key});

  @override
  State<FinishRefund> createState() => _FinishExchangeeState();
}

class _FinishExchangeeState extends State<FinishRefund> {
  late ScannedUser scannedUser;
  late RefundUser refundUser;

  @override
  void initState() {
    super.initState();
    refundUser = RefundUser();
    scannedUser = ScannedUser();
  }

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
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '송금 ${refundUser.inquire} 요청이\n완료',
                              style: TextStyle(
                                color: Color(0xFF624A43),
                                fontSize: 30,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '되었습니다!',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        // 패딩 설정
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Lottie.asset("assets/lottie/check.json"),
                        ),
                      ),
                      Text(
                          "송금 취소 처리는",
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                          "최소 1주일 이상 소요됩니다.",
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      )
                      ,Text(
                          "처리 완료 후",
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      ),Text(
                          "알림으로 알려드리겠습니다.",
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 20,
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
                      MaterialPageRoute(builder: (context) => MainAccount()),
                    );
                  },
                  child: Text(
                    '홈으로',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}