// 송금 완료 화면
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../User/userData.dart';
import '../mainAccount.dart';
import 'inputTransfor.dart';

class FinishExchange extends StatefulWidget {
  const FinishExchange({super.key});

  @override
  State<FinishExchange> createState() => _FinishExchangeeState();
}

class _FinishExchangeeState extends State<FinishExchange> {
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return WillPopScope( //뒤로가기 누를시 홈 화면으로 이동
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainAccount()));
        return false; // 화면을 떠나지 않도록 false를 반환합니다.
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFFFBD3),
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
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '매듭 보내기가',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFF8D4D),
                          fontSize: 40,
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
                              color: Color(0xFFFF8D4D),
                              fontSize: 40,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '되었습니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
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
                          height: 250,
                          width: 250,
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
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputTransfor(userId: userData.id)),
                    );
                  },
                  child: Text(
                    '예, 추가로 매듭을 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: 23,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(346, 73),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFFFFD852),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainAccount()));
                  },
                  child: Text(
                    '아니요, 매듭을 그만 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(346, 73),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF4B4A48),
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

