import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/error/refuseBluetoothError.dart';
import 'package:suntown/main/Exchange/reciever/chooseAccount.dart';

class PermitBluetooth extends StatelessWidget {
  const PermitBluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3), //0xff +
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset("assets/lottie/bluetooth.json"),
                    ),
                    SizedBox(height: 20), //padding
                    Text(
                      '블루투스 연결 허용 메세지',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Spacer(),
              //버튼
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseAccount()));
                  },
                  child: Text('연결 허용'),
                ),
              ),
              SizedBox(height: 20), //padding
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RefuseBlueError()));
                    //원래는 종료가 되어야 하는데, ui 편의상 지금은 refuseBluetoothError로 연결
                  },
                  child: Text('연결 거절'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
