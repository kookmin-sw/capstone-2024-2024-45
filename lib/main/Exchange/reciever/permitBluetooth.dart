import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PermitBluetooth extends StatelessWidget {
  const PermitBluetooth({super.key});



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
            Text('블루투스 연결 허용 메세지'),
          ],
        ),
      ),
    );
  }
}