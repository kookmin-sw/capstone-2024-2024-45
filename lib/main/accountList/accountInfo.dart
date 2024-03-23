import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/inputTransfor.dart';
import 'package:suntown/main/saving/savingHistory/savingHistory.dart';
class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            // SizedBox 대신 Container를 사용 가능
            width: 346,
            height: 73,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InputTransform()));
              },
              child: Text('햇살 보내기'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            // SizedBox 대신 Container를 사용 가능
            width: 346,
            height: 73,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Savinghistory()));
              },
              child: Text('거래 확인하기'),
            ),
          ),
        ]),
      ),
    );
  }
}
