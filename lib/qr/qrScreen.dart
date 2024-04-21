import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'greetingSection.dart';
import 'qrScreenContent.dart';
import 'qrScreenProvider.dart';

class QrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Text("flutter_qr"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GreetingSection(), // GreetingSection 위젯 추가
            SizedBox(height: 30),
            ChangeNotifierProvider( // QrScreenProvider를 제공
              create: (context) => QrScreenProvider(),
              child: QrScreenContent(), // _QrScreenContent 위젯 추가
            ),
          ],
        ),
      ),
    );
  }
}