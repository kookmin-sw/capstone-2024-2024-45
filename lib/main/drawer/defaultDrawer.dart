import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/main/alert/singUpFail/logoutFailAlert.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_logout.dart';

import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:suntown/utils/api/user/userProfileGet.dart';
import '../manage/userInfoManage.dart';
import 'persInfo/persInfoCheck.dart';
import '../../utils/screenSizeUtil.dart';
import '../../User/userData/UserF.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class defaultDrawer extends StatefulWidget {
  const defaultDrawer({super.key});

  @override
  State<defaultDrawer> createState() => _defaultDrawerState();
}

class _defaultDrawerState extends State<defaultDrawer> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              // backgroundImage: NetworkImage(testUser.avatar),
              backgroundImage : AssetImage('assets/images/default_profile.jpeg'),
            ),
            accountName: Text(''),
            accountEmail: Text(''),
            decoration: BoxDecoration(
              color: Color(0xFFDDE8E1),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: Text('로그아웃'),
            onTap: () async {
              try{
                final state = await KaKaoLogoutState().kakaoLogout();
                if(state){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => signingUP()));
                } else{
                  LogoutFailAlert.showExpiredCodeDialog(context, defaultDrawer());
                }
              }catch (e){
                print("로그아웃 실패 : $e");
                LogoutFailAlert.showExpiredCodeDialog(context, defaultDrawer());
              }
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
