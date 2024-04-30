import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/nameScreen.dart';
import '../../utils/screenSizeUtil.dart';

import 'package:suntown/main/defaultAccount.dart';

class openAccount extends StatefulWidget {
  const openAccount({super.key});

  @override
  State<openAccount> createState() => _openAccountState();
}

class _openAccountState extends State<openAccount> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, // 뒤로가기 아이콘 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 왼쪽에 추가할 아이콘
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Expanded(
                child:SingleChildScrollView(
                    child : Column(
                      children: [
                        Container(
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.7,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width:  screenWidth* 0.8,
                                  height: screenHeight * 0.5,
                                  child: Text(
                                    '매듭거래를 위한\n창고 개설을 시작해 볼까요?',
                                    style: TextStyle(
                                      color: Color(0xFF4B4A48),
                                      fontSize: screenWidth * 0.06,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  top: 152,
                                  child: Container(
                                    width: screenWidth* 0.8,
                                    height: screenHeight * 0.3,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth* 0.8,
                                          height: screenHeight * 0.3,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: screenWidth* 0.65,
                                                  height: screenWidth* 0.3,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 73,
                                                        top: 1,
                                                        child: SizedBox(
                                                          width: screenWidth * 0.6, //270
                                                          height: screenHeight * 0.03,//36,
                                                          child: Text(
                                                            '창고 만들기',
                                                            style: TextStyle(
                                                              color: Color(0xFF727272),
                                                              fontSize: screenWidth * 0.045,
                                                              fontFamily: 'Noto Sans KR',
                                                              fontWeight: FontWeight.w500,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        top: 0,
                                                        child: Container(
                                                          width: 44,
                                                          height: 44,
                                                          decoration: ShapeDecoration(
                                                            color: Color(0xFFFFD852),
                                                            shape: OvalBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 6,
                                                        top: 7,
                                                        child: SizedBox(
                                                          width: 31,
                                                          height: 24,
                                                          child: Text(
                                                            '1',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0xFF727272),
                                                              fontSize: screenWidth * 0.06,
                                                              fontFamily: 'Noto Sans KR',
                                                              fontWeight: FontWeight.w500,
                                                              height: 0,
                                                            ),
                                                          ),
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
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => nameScreen()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  backgroundColor: const Color(0xFFFFD852),
                  minimumSize: Size.fromHeight(73),

                  foregroundColor: const Color(0xFF4B4A48),

                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("창고 만들기"),
              )
          ],
        ),
      ),
    );
  }
}
