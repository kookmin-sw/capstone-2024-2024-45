import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/loadingBluetooth.dart';
import 'package:suntown/main/alert/refuseBluetoothAlert.dart';

class RefuseBlueError extends StatefulWidget {
  const RefuseBlueError({super.key});

  @override
  State<RefuseBlueError> createState() => _RefuseBlueErrorState();
}

class _RefuseBlueErrorState extends State<RefuseBlueError> {
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
              child: Lottie.asset("assets/lottie/sad.json"),
            ),
            SizedBox(height: 20), //padding
            Text('블루투스 연결 거절 메세지 자리'),
            SizedBox(height: 20), //padding
            //버튼
            SizedBox(
              // SizedBox 대신 Container를 사용 가능
              width: 346,
              height: 73,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingBluetooth()));
                },
                child: Text('예, 송금 요청을 다시 보냅니다.'),
              ),
            ),
            SizedBox(height: 20), //padding
            SizedBox(
              // SizedBox 대신 Container를 사용 가능
              width: 346,
              height: 73,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RefuseBluetoothAlert()));
                  //원래는 종료가 되어야 하는데, ui 편의상 지금은 refuseBluetoothError로 연결
                },
                child: Text('아니요, 송금 요청을 취소합니다'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}