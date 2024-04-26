import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("권한이 거부되었습니다"),
      content: Text("카메라 권한을 허용해야 이 기능을 사용할 수 있습니다."),
      actions: <Widget>[
        ElevatedButton(
          child: Text("설정으로 이동"),
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
            openAppSettings(); // 앱 설정 화면으로 이동
          },
        ),
      ],
    );
  }
}