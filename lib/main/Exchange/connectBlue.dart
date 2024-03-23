import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectBlue extends StatelessWidget {
  const ConnectBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3), //0xff +
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset("assets/lottie/bluetooth.json"),
            ),
            SizedBox(height: 20), //padding
            Text('블루투스 연결 글귀 들어가는 자리'),
          ],
        ),
      ),
    );
  }
}