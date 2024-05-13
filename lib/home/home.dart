import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';

import '../permission/permissionWidget.dart';
import '../utils/screenSizeUtil.dart';
import 'package:firebase_auth/firebase_auth.dart' ;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final page = const MainAccount();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      checkPermissionsAndNavigate();
    });
  }

  Future<void> checkPermissionsAndNavigate() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;

    if (cameraPermissionStatus.isGranted) { // 카메라 권한이 설정 되어있는지 확인
      /*
      import 'package:firebase_auth/firebase_auth.dart' ;
      import 'package:suntown/main/manage/accountInfoManage.dart';
      import 'package:suntown/main/manage/userInfoManage.dart';
      import 'package:suntown/main/signingUp/signingScreen.dart';
      import 'package:suntown/main/defaultAccount.dart';
      * */
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) { // 로그인된 User가 존재하면 account 화면으로
          try{
            String user_id = await UserInfoManage().getUserId() ?? '';
            String account_id = await AccountInfoMange().getAccount_id(user_id:user_id);
            if(account_id.length > 0){ // 계좌가 생성된 user면 Main계좌 화면으로
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainAccount()));
            }else { // 계좌가 생성되지 않은 user면 계좌 만들기 화면으로
              Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
            }
          }catch (e) { // 만약 user_id를 가져오거나 account_id를 불러오는데 문제가 생겼다면 아직 회원가입이 안되어 있어 계좌가 없는 유저일 가능성이 큼.
            print(e);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => defaultAccount()));
          }
        }else{ // 로그인된 User가 없으면 로그인 화면으로
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => signingUP()));
        }
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PermissionWidget()));
    }
  }

  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFFDF3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/images/knotWarehouse.png'),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
              ])),
        ],
      ),
    );
  }
}