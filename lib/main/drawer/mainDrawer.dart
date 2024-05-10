import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:suntown/main/signingUp/signingScreen.dart';
import '../manage/userInfoManage.dart';
import 'persInfo/persInfoCheck.dart';

class mainDrawer extends StatefulWidget {
  const mainDrawer({super.key});

  @override
  State<mainDrawer> createState() => _mainDrawerState();
}

class _mainDrawerState extends State<mainDrawer> {
  // late bool status;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _getUserInfo();
  // }
  //
  // Future<void> _getUserInfo() async {
  //   status = await UserInfoMange().getUserInfo();
  //   setState(() {}); // 상태 갱신
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              // backgroundImage:  사용자 이미지
            ),
            accountName: Text('jieun'),
            accountEmail: Text('abcd1234@naver.com'),
            decoration: BoxDecoration(
              color: Color(0xFFDDE8E1),
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('개인정보 수정'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => persInfo()));
              print('개인정보 수정 클릭');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('관리자 문의'),
            onTap: () {
              print('관리자 문의 클릭');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: Text('로그아웃'),
            onTap: () {
              try{
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => signingUP()));
              }catch (e){
                print("로그아웃 실패 : $e");
              }
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
