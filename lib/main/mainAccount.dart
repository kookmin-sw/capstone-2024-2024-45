//메인 화면 구현 계좌(List 아님!!!)

import 'package:flutter/material.dart';

import '../qr/qrScanner.dart';
import '../qr/qrScreen.dart';
import '../qr/qrScreenContent.dart';

class MainAccount extends StatefulWidget {
  const MainAccount({super.key});

  @override
  State<MainAccount> createState() => _MainAccountState();
}

Map<String, dynamic>? apiResult; //http 주소 받아올

class _MainAccountState extends State<MainAccount> {

  // 초기화
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; //일단 뒤로가기 막아둠. 뒤로가기 하면 로딩 화면이나 이런 화면으로 가길래..
      }, //백그라운드 실행도 괜찮은 것 같기는 함
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Flutter App",
              textAlign: TextAlign.center,
            ),
          ),
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
                        Container(
                          width: 344,
                          height: 73,
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 30,
                            bottom: 10,
                          ),
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFE2E2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Text("\u{1F493}",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Noto Sans KR',
                                ),),
                              Spacer(),
                              //말풍선 텍스트
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  // 텍스트를 말풍선 아래에 위치시킴
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "오늘도 나눔에 앞장서는",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 16,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "아름다운 당신을 응원합니다",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xFF727272),
                                          fontSize: 16,
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 343,
                          height: 231,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 346,
                                height: 231,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side:
                                    BorderSide(width: 1, color: Color(0xFFF9DEDE)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 317,
                                      height: 200,
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        left: 10,
                                        right: 10,
                                        bottom: 30,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '경로당 창고',
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
                                  ],
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
                          fixedSize: Size(346, 73),
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
                          fixedSize: Size(346, 73),
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
                          fixedSize: Size(346, 73),
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
