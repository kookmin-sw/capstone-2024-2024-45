import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';

import 'package:suntown/utils/HttpGet.dart';
import '../../User/User.dart';
import '../../User/UserAccountInfo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late User user;
  late UserAccountInfo accountInfo;

  @override
  void initState() {
    super.initState();
    user = User();
    accountInfo = UserAccountInfo();
    // 차례대로 수행될 수 있도록
    // _fetchUserData가 완료된 후 _fetchUserAccountData를 호출하도록 함
    _fetchUserData().then((_) {
      _fetchUserAccountData().then((_) {
        _navigateToNextScreen();
      });
    });
  }

  // API 요청을 보내어 사용자 데이터를 가져오는 메서드
  Future<void> _fetchUserData() async {
    print('start _fetchUserData');
    Map<String, dynamic> userdata =
    await httpGet(path: '/api/users/2}');
    if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
      user.initializeData(userdata["data"]);
    }else if (userdata.containsKey('statusCode') && userdata['statusCode'] == 404){
      user.id = '' ;
    } else {
      debugPrint('Failed to fetch user data');
    }
    print('end _fetchUserData');
  }
  // 회원정보를 확인하고 다음으로 넘어갈 화면을 결정
  // API 요청을 보내어 사용자 데이터를 가져오는 메서드
  Future<void> _fetchUserAccountData() async {
    print('start _fetchUserAccountData');
    Map<String, dynamic> userdata =
    await httpGet(path: '/api/users/2'); //accountId로 변경할 것임
    if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
      accountInfo.initializeData(userdata["data"]);
    } else if (userdata.containsKey('statusCode') && userdata['statusCode'] == 404){
      accountInfo.AccountId = '' ;
    } else {
      debugPrint('Failed to fetch user data');
    }
    print('end _fetchUserAccountData');
  }
 // 사용자 정보유무, 계좌 개설 여부에 따라 제공되는 화면 달라짐.
  void _navigateToNextScreen() {
    setState(() {
      if(user.id == ''){
        // 회원정보가 없으므로 회원가입 화면으로
        Navigator.push(context, MaterialPageRoute(builder: (context) => signingUP()));
      } else if (accountInfo.AccountId == ''){
        // 게좌개설이 안되어 있으므로 계좌개설 화면으로
        Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
      } else {
        //계좌개설, 회원가입 모두 되어 있으므로 메인 계좌 화면으로
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainAccount()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3), //0xff +
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset("assets/lottie/sun.json"),
            ),
            const SizedBox(height: 20),
            const Text(
              '매듭창고',
              style: TextStyle(fontSize: 55),
            ),
          ],
        ),
      ),
    );
  }
}


