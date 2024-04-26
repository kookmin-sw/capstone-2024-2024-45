import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';

import '../../User/User.dart';
import '../../utils/screenSizeUtil.dart';
import '../alert/correctionAlertDialog.dart';
import 'inputTransfor.dart';

/*
송금 확인 화면
 */

class CheckExchange extends StatefulWidget {
  const CheckExchange({super.key});

  @override
  State<CheckExchange> createState() => _CheckExchangeState();
}

class _CheckExchangeState extends State<CheckExchange> {
  User userData = User();

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            flex: 50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // 여기에 프로필 이미지 설정
                    radius: screenWidth * 0.15, // 이미지 크기 설정
                    backgroundImage:
                    NetworkImage(userData.avatar), // 네트워크 이미지 사용 예시
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userData.lastName}',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 35,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '님에게',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 30,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible( //넘칠 경우를 대비...거의 없을듯 싶지만 혹시 모르니
                          child: Text(
                            '${NumberFormat("#,###").format(userData.amount)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFF8D4D),
                              fontSize: 40,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '매듭을',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 30,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '보낼까요?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: 40,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoadingExchange()));
            },
            child: Text(
              '예, 매듭을 보냅니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4B4A48),
                fontSize: 23,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
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
            onPressed: () {
              CorrectAlertDialog.show(context);
            },
            child: Text('수정하고 싶어요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                  height: 0,
                )),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Color(0xFF4B4A48),
            ),
          ),
        ]),
      ),
    );
  }
}
