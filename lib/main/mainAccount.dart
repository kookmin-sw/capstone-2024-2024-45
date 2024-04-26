//메인 화면 구현 계좌(List 아님!!!)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suntown/User/UserAccountInfo.dart';

import '../User/User.dart';
import '../bubble.dart';
import '../qr/qrScanner.dart';
import '../qr/qrScreen.dart';
import '../utils/HttpGet.dart';
import '../utils/screenSizeUtil.dart';

/*
흐름
포그라운드로 돌아오면 didChangeAppLifecycleState를 통해
_checkCameraPermission()을 다시 실행. 권한 허용여부를 볼 수 있어야 한다.
 */

class MainAccount extends StatefulWidget {
  const MainAccount({super.key});

  @override
  State<MainAccount> createState() => _MainAccountState();
}

Map<String, dynamic>? apiResult; //http 주소 받아올

class _MainAccountState extends State<MainAccount>{
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

  // API 요청을 보내어 사용자 데이터를 가져오는 메서드
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

    return WillPopScope(
      onWillPop: () async {
        return false; //일단 뒤로가기 막아둠. 뒤로가기 하면 로딩 화면이나 이런 화면으로 가길래..
      }, //백그라운드 실행도 괜찮은 것 같기는 함
      child: Scaffold(
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
                  Expanded(
                    flex: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopSideBubble(),//말풍선
                        const SizedBox(height: 30),
                        Container(
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.85,
                                height: screenHeight * 0.3,
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
                                        Text(
                                          '경로당 창고', //accountInfo 가져오면 변경
                                          // '${accountInfo.AccountName} 창고',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFA7931),
                                            fontSize: 25,
                                            fontFamily: 'Noto Sans KR',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: 0.03,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Text(
                                          '1,300',
                                          // '${accountInfo.Balance} 창고',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF4B4A48),
                                            fontSize: 50,
                                            fontFamily: 'Noto Sans KR',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Text(
                                          '매듭',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF3C3C3C),
                                            fontSize: 20,
                                            fontFamily: 'Noto Sans KR',
                                            fontWeight: FontWeight.w300,
                                            height: 0.06,
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
                  ),
                  Spacer(),
                  Column(
                    children: [
                      ElevatedButton(
                        child: const Text(
                          '매듭 보내기',
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
                                MaterialPageRoute(builder: (context) => qrScanner()));
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
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          '매듭 받기',
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QrScreen()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color(0xFFFF8D4D),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          '주고 받은 매듭 확인하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color(0xFF4B4A48),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
