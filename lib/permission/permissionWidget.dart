import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'permissionContent.dart';
import 'permissionTopMessage.dart';
import 'permissionNotifier.dart';

class PermissionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PermissionTopMessage(), // 상단 화면 위젯
            SizedBox(height: 30),
            ChangeNotifierProvider( //여기 내부에서 버튼을 생성
              create: (context) => PermissionNotifier(),
              child: PermissionContent(), // 화면 추가
            ),
          ],
        ),
      ),
    );
  }
}