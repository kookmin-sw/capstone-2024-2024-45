import 'package:flutter/material.dart';

class RefuseBluetoothAlert extends StatelessWidget {
  const RefuseBluetoothAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("블루투스 취소 alert",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}

