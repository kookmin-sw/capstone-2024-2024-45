import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/reciever/permitBluetooth.dart';

class LoadingBluetooth extends StatefulWidget {
  const LoadingBluetooth({super.key});

  @override
  State<LoadingBluetooth> createState() => _LoadingBluetoothState();
}

class _LoadingBluetoothState extends State<LoadingBluetooth> {
  //임시 화면 넘김 코드, 차후 상대방이 선택시 -> 넘어가는 방향으로 수정 예정
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PermitBluetooth()));
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
              child: Lottie.asset("assets/lottie/loading.json"),
            ),
            SizedBox(height: 20), //padding
            Text('블루투스 로딩 글귀 들어가는 자리',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}