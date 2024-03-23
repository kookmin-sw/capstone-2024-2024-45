import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/choose/chooseExchange.dart';

class ConnectBlue extends StatefulWidget {
  const ConnectBlue({super.key});

  @override
  State<ConnectBlue> createState() => _ConnectBlueState();
}

class _ConnectBlueState extends State<ConnectBlue> {

  //임시 화면 넘김 코드, 차후 블루투스 연결시 -> 바뀌는 방향으로 수정 예정
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseExchange()));
    });
  }

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