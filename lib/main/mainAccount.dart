//메인 화면 구현 계좌(List 아님!!!)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/BeforeinputTransfor.dart';
import 'package:suntown/main/Exchange/minutesInputTransfor.dart';

import 'package:suntown/main/drawer/mainDrawer.dart';

import '../User/test/testAccountData.dart';
import '../User/test/testAccountListData.dart';
import '../bubble.dart';

import '../utils/api/test/testMainAccountDetailGet.dart';
import '../utils/api/test/testMainAccountGet.dart';
import '../utils/screenSizeUtil.dart';

import '../qr/qrScanner.dart';
import '../qr/qrScreen.dart';
import '../utils/time/changeAmountToTime.dart';
import '../utils/time/changeTimeToAmount.dart';
import 'Exchange/inputTransfor.dart';
import 'alert/apiFail/ApiRequestFailAlert.dart';
import 'accountList/exchangeList.dart';
import 'alert/blocked/BlockedAccountAlert.dart';
import 'manage/userInfoManage.dart';

/*
흐름
포그라운드로 돌아오면 didChangeAppLifecycleState를 통해
_checkCameraPermission()을 다시 실행. 권한 허용여부를 볼 수 있어야 한다.
 */

/*
차후 block 계좌 연동해야함
 */

class MainAccount extends StatefulWidget {
  const MainAccount({super.key});

  @override
  State<MainAccount> createState() => _MainAccountState();
}

Map<String, dynamic>? apiResult; //http 주소 받아올

class _MainAccountState extends State<MainAccount> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  bool dataLoad = false;
  List<String> userAccountIds = []; //account 정보를 담아옴

  late TestAccountData testAccountData;
  late String userId;
  late int totalTime;
  late String timeStr;

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();

  @override
  void initState() {
    super.initState();
    testAccountData = TestAccountData();
    totalTime = 0;
    timeStr = "";
    _initializeUserId();
  }

  // _userId를 초기화하는 메서드
  Future<void> _initializeUserId() async {
    userId = await secureStorage.read(key: 'userId') ?? "";
    testAccountData.userId = userId;
    fetchAccountData(userId);
  }

  Future<void> fetchAccountData(String userId) async {
    try {
      final Map<String, dynamic> response =
          await testMainAccountDetailGet(userId);

      if (response["statusCode"] == 200) {
        //서버 응답
        testAccountData.initializeData(response["data"]);
        setState(() {
          changeToTime(testAccountData.availableBudget);
          dataLoad = true;
        });
      } else {
        ApiRequestFailAlert.showExpiredCodeDialog(context, MainAccount());
        print(response);
        debugPrint('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context, MainAccount());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

  void changeToTime(int balance){
    List<int> time =
    changeAmountToTime.changeAmountToTime(balance);

    int hours = time[0];
    int minutes = time[1];

    totalTime = changeTimeToAmount.changeTimeToAmount(hours, minutes);
    timeStr = "${hours} 시간 ${minutes} 분";
  }

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return RefreshIndicator(
      onRefresh: () async {
        // 새로고침 작업을 수행하는 비동기 함수를 호출합니다.
        await fetchAccountData(userId); // 데이터를 다시 가져오는 메서드 호출
      },
      child: WillPopScope(
        onWillPop: () async {
          return false; //일단 뒤로가기 막아둠. 뒤로가기 하면 로딩 화면이나 이런 화면으로 가길래..
        }, //백그라운드 실행도 괜찮은 것 같기는 함
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('시간 은행'),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications), // 메뉴 아이콘
                onPressed: () {
                  // 메뉴를 클릭했을 때 수행할 동작
                },
              ),
            ],
          ),
          drawer: MainDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: dataLoad
                  ? Column(
                      children: [
                        // 나눔 장려 문구 -----------------
                        Expanded(
                          flex: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TopSideBubble(), //말풍선
                              SizedBox(height: screenHeight * 0.04),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFD0BAAD)),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${testAccountData.nickName}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF624A43),
                                                fontSize: 25,
                                                fontFamily: 'Noto Sans KR',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              timeStr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF4B4A48),
                                                fontSize: 30,
                                                fontFamily: 'Noto Sans KR',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '( 총 ${totalTime} 분 )',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF3C3C3C),
                                                fontSize: 20,
                                                fontFamily: 'Noto Sans KR',
                                                fontWeight: FontWeight.w300,
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
                              child: Text(
                                '시간 보내기',
                                style: TextStyle(
                                  color: Color(0xFFDDE9E2),
                                  fontSize: 20,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                testAccountData.isBlocked ?
                                Blockedaccountalert.showExpiredCodeDialog(context) :
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => qrScanner()))
                                      .then((_) {
                                    fetchAccountData(userId);
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    screenWidth * 0.85, screenHeight * 0.09),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Color(0xFF2C533C),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.025,
                            ),
                            ElevatedButton(
                              child: Text(
                                '시간 받기',
                                style: TextStyle(
                                  color: Color(0xFF2C533C),
                                  fontSize: 20,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                testAccountData.isBlocked ?
                                Blockedaccountalert.showExpiredCodeDialog(context) :
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => QrScreen())
                                  ).then((_) {
                                    fetchAccountData(userId);
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    screenWidth * 0.85, screenHeight * 0.09),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Color(0xFFDDE9E2),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.025,
                            ),
                            ElevatedButton(
                              child: Text(
                                '주고 받은 시간 확인하기',
                                style: TextStyle(
                                  color: Color(0xFF624A43),
                                  fontSize: 20,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => exchangeList())).
                                  then((_) {
                                    fetchAccountData(userId);
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    screenWidth * 0.85, screenHeight * 0.09),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Color(0xFFD3C2BD),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Lottie.asset("assets/lottie/loading.json"),
            ),
          ),
        ),
      ),
    );
  }
}
