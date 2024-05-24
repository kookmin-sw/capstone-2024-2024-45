import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/main/alert/singUpFail/logoutFailAlert.dart';
import 'package:suntown/main/drawer/inquiry/inquiryStart.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_logout.dart';

import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:suntown/utils/api/user/userProfileGet.dart';
import 'persInfo/persInfoCheck.dart';
import '../../utils/screenSizeUtil.dart';
import '../../User/userData/User.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String nickName = 'Loading...';
  String address = 'Loading...';
  User user = User();
  String profileImage = '';
  bool dataload = false;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  // user profile 불러오기
  Future<void> fetchProfileData() async {
    final accessToken = await secureStorage.read(key: 'kakaoToken');
    final userId = await secureStorage.read(key: 'userId');
    try {
      final value = await userProfileGet(userId: userId.toString(), accessToken: accessToken.toString());
      setState(() {
        user.initializeData(value["data"]);
        dataload = true;
        nickName = user.nickName;
        address = user.address;
        profileImage = user.profileImage;
      });
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context, PersInfo());
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
              backgroundImage: profileImage.isNotEmpty
                  ? NetworkImage(profileImage)
                  : AssetImage('assets/images/default_profile.jpeg') as ImageProvider,
            ),
            accountName: Text(nickName),
            accountEmail: Text(address),
            decoration: BoxDecoration(
              color: Color(0xFFDDE8E1),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('개인정보'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PersInfo()));
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => inquiryStart()));
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
            onTap: () async {
              try {
                final state = await KaKaoLogoutState().kakaoLogout();
                if (state) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => signingUP()));
                } else {
                  LogoutFailAlert.showExpiredCodeDialog(context, MainDrawer());
                }
              } catch (e) {
                print("로그아웃 실패 : $e");
                LogoutFailAlert.showExpiredCodeDialog(context, MainDrawer());
              }
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
