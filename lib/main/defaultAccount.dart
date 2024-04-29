//디폴트 계좌 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suntown/User/UserAccountInfo.dart';
import 'package:suntown/main/signingUp/openAccount.dart';

import '../User/User.dart';
import '../bubble.dart';
import '../utils/HttpGet.dart';
import '../utils/screenSizeUtil.dart';

class defaultAccount extends StatefulWidget {
  const defaultAccount({super.key});

  @override
  State<defaultAccount> createState() => _defaultAccounttState();
}

Map<String, dynamic>? apiResult; //http 주소 받아올

class _defaultAccounttState extends State<defaultAccount>{
  late User user;
  late UserAccountInfo accountInfo;

  @override
  void initState() {
    super.initState();
    user = User();
    accountInfo = UserAccountInfo();
    _fetchUserData(); // initState에서 데이터 가져오도록 호출
    _fetchUserAccountData();
  }

  // API 요청을 보내어 사용자 데이터를 가져오는 메서드
  Future<void> _fetchUserData() async {
    // userId를 사용하여 API 요청을 보냄
    Map<String, dynamic> userdata =
    await httpGet(path: '/api/users/${user.id}'); //name..? 암튼 구별 가능한 데이터
    // API 응답을 통해 사용자 데이터 업데이트

    if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
      // 사용자 데이터를 업데이트
      user.initializeData(userdata["data"]);
    } else {
      // API 요청 실패 처리
      debugPrint('Failed to fetch user data');
    }
  }

  // API 요청을 보내어 사용자 데이터를 가져와 화면 처리
  Future<void> _fetchUserAccountData() async {
    // userId를 사용하여 API 요청을 보냄
    Map<String, dynamic> userdata =
    await httpGet(path: '/api/users/${user.id}'); //accountId로 변경할 것임
    // API 응답을 통해 사용자 데이터 업데이트

    if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
      // 사용자 데이터를 업데이트
      accountInfo.initializeData(userdata["data"]);
    } else {
      // API 요청 실패 처리
      debugPrint('Failed to fetch user data');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 아이콘 제거
          leading: IconButton(
            icon: Icon(Icons.notifications), // 왼쪽에 추가할 아이콘
            onPressed: () {
              //공지사항. 알람
            },
          ),
          title: Center(
            child: Text(
              "매듭 창고",
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu), // 메뉴 아이콘
              onPressed: () {
                // 메뉴를 클릭했을 때 수행할 동작
              },
            ),
          ],
        ),
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
                      const SizedBox(height: 30),
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
                                                  '매듭 창고를\n만들어 주세요.',
                                                  style: TextStyle(
                                                    color: Color(0xFF4B4A48),
                                                    fontSize: screenWidth * 0.075,
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
                                                  '창고를 만들어야, \n매듭창고를 사용할 수 있어요.',
                                                  style: TextStyle(
                                                    color: Color(0xFF727272),
                                                    fontSize: screenWidth * 0.037,
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
                                        '창고 만들기',
                                        style: TextStyle(
                                          color: Color(0xFF4B4A48),
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
                                        backgroundColor: Color(0xFFFFD852),
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