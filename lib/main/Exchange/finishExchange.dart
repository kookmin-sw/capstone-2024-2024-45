// 송금 완료 화면
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/choose/chooseExchange.dart';
import 'package:suntown/main/accountList/accountInfo.dart';


class FinishExchange extends StatefulWidget {
  const FinishExchange({super.key});

  @override
  State<FinishExchange> createState() => _FinishExchangeeState();
}

class _FinishExchangeeState extends State<FinishExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '송금 성공!',
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

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0), // 패딩 설정
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Lottie.asset("assets/lottie/handshake.json"),
                ),
              ),
              Text(
                '추가 송금 하시겠습니까?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: 30,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              Spacer(),
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChooseExchange())
                    );
                  },
                  child: Text('예, 햇살을 보냅니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: 25,
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
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AccountInfo()));
                  },
                  child: Text('아니요, 햇살을 그만 보냅니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      )
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
              ),
            ]
          ),
        )
      ),
    );
  }
}

