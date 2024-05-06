import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';


class defatulDrawer extends StatelessWidget {
  const defatulDrawer({super.key});

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
              color: Color(0xFFFFD852),
            ),
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
