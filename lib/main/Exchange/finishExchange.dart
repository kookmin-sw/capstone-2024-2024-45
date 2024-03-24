import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/accountList/accountInfo.dart';

class FinishExchange extends StatelessWidget {
  const FinishExchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3), //0xff +
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // 패딩 설정
              child: SizedBox(
                height: 250,
                width: 250,
                child: Lottie.asset("assets/lottie/handshake.json"),
              ),
            ),
            Text(
              '송금완료 글귀 들어가는 자리',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20), // 추가 간격
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInfo()),
                );
              },
              child: Text('확인'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(346, 73), // 최소 크기 설정
                // 버튼 내부 텍스트 스타일 조정
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        )
      ),
    );
  }
}