//메인 화면 구현

import 'package:flutter/material.dart';
import 'package:suntown/main/accountList/account.dart';
import 'package:suntown/main/accountList/accountInfo.dart';

class MainAccount extends StatefulWidget {
  const MainAccount({super.key});

  @override
  State<MainAccount> createState() => _MainAccountState();
}

class _MainAccountState extends State<MainAccount> {
  final page = AccountInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('main')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('계좌1'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => page
                    ),
                );
              }
              //dense: true,
            ),
          ),
        ],
      ),
    );
  }
}
