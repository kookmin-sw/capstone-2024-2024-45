import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:suntown/main/signingUp/signingScreen.dart';
import '../manage/userInfoManage.dart';
import 'persInfo/persInfoCheck.dart';
import '../../utils/screenSizeUtil.dart';
import '../../User/userData/UserF.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class mainDrawer extends StatefulWidget {
  const mainDrawer({super.key});

  @override
  State<mainDrawer> createState() => _mainDrawerState();
}

class _mainDrawerState extends State<mainDrawer> {
  late String userName ;
  late String mobile_number;
  late UserF user;
  late bool dataload;
  @override
  void initState() {
    dataload = false;
    user = UserF();
    fetchData();
  }

  // userdata 불러오기
  Future<void> fetchData() async {
    try {
      final value = await UserInfoManage().getUserInfo();
      dataload = true;
      user.initializeData(value["result"]['user_info']);
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context, persInfo());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

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
            accountName: Text('jieun'),
            accountEmail: Text('abcd1234@naver.com'),
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
