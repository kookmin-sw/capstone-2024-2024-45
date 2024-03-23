import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingExchange extends StatelessWidget {
  const LoadingExchange({super.key});

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
              child: Lottie.asset("assets/lottie/loading.json"),
            ),
            SizedBox(height: 20), //padding
            Text('송금 로딩 글귀 들어가는 자리'),
          ],
        ),
      ),
    );
  }
}