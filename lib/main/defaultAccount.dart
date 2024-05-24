//디폴트 계좌 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/User/UserAccountInfo.dart';
import 'package:suntown/main/drawer/mainDrawer.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/openAccount.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:suntown/utils/api/user/userProfileGet.dart';

// import '../User/User.dart';
import '../bubble.dart';
import '../utils/screenSizeUtil.dart';
import 'drawer/defaultDrawer.dart';
import 'mainAccount.dart';


class defaultAccount extends StatefulWidget {
  const defaultAccount({super.key});

  @override
  State<defaultAccount> createState() => _defaultAccounttState();
}

Map<String, dynamic>? apiResult; //http 주소 받아올

class _defaultAccounttState extends State<defaultAccount>{

  // late User user;
  late UserAccountInfo accountInfo;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initializeData();
    fetchProfileData();
  }

  fetchProfileData() async {
    final accessToken = await secureStorage.read(key: 'accessToken');
    final userId = await secureStorage.read(key: 'userId');

    final value = await userProfileGet(userId: userId.toString(), accessToken: accessToken.toString());
    print(value);
  }

  // user가 account_id를 가지고 있으면 바로 mainAccount로 이동
  Future<void> _initializeData() async {
    auth.FirebaseAuth.instance.authStateChanges().listen((auth.User? user) async {
      if (user != null) {
        try{
          String user_id = await UserInfoManage().getUserId() ?? '';
          String account_id = await AccountInfoMange().getAccount_id(user_id:user_id);
          if(account_id.length > 0){ // 계좌가 생성된 user면 Main계좌 화면으로
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainAccount()));
          }
        }catch (e){
          print(e);
        }
      }
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('시간은행'),
          centerTitle: true,
          elevation : 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications), // 메뉴 아이콘
              onPressed: () {
                // 메뉴를 클릭했을 때 수행할 동작
              },
            ),
          ],
        ),
        drawer : MainDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
                children: [
                  // 나눔 장려 문구 -----------------
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopSideBubble(),//말풍선
                      SizedBox(height: 30),
                      Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.44,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(

                              width: screenWidth * 0.85,
                              height: screenHeight * 0.44,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side:
                                  BorderSide(width: 1, color: Color(0xFFF9DEDE)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Center(
                                child :
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 133,
                                      child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: SizedBox(
                                                width: 300,
                                                height: 80,
                                                child: Text(
                                                  '시간 계좌를\n만들어 주세요.',
                                                  style: TextStyle(
                                                    color: Color(0xFF4B4A48),
                                                    fontSize: 30,
                                                    fontFamily: 'Noto Sans KR',
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left : 0,
                                              top: 80,
                                              child: SizedBox(
                                                width: screenWidth * 0.5,//200,
                                                height: screenHeight *  0.3,//43,
                                                child: Text(
                                                  '계좌를 만들어야, \n시간은행을 사용할 수 있어요.',
                                                  style: TextStyle(
                                                    color: Color(0xFF727272),
                                                    fontSize: 16,
                                                    fontFamily: 'Noto Sans KR',
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.1,
                                                    letterSpacing: 0.02,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                      )
                                    ),
                                    SizedBox(height: screenHeight * 0.04),
                                    ElevatedButton(
                                      child: const Text(
                                        '계좌 만들기',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => openAccount()));
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor:Color(0xFF2C533C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
    );
  }
}