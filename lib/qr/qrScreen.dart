import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/screenSizeUtil.dart';
import 'qrPageTopSection.dart';
import 'qrScreenContent.dart';
import 'qrScreenProvider.dart';

class QrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Center(
          child: Text(
            "매듭 창고",
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          // 빈 아이콘을 추가하여 빈 공간을 만듭니다.
          IconButton(
            icon: Container(),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            QrPageTopSection(), // GreetingSection 위젯 추가
            SizedBox(height: screenHeight * 0.04),
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