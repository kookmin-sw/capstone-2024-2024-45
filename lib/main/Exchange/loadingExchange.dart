import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/main/Exchange/finishExchange.dart';

import '../../User/SendApi.dart';
import '../../User/User.dart';
import '../../utils/http_put.dart';
import '../../utils/screenSizeUtil.dart';

class LoadingExchange extends StatefulWidget {
  const LoadingExchange({Key? key}) : super(key: key);

  @override
  State<LoadingExchange> createState() => _LoadingExchangeState();
}

class _LoadingExchangeState extends State<LoadingExchange> {
  User userData = User();
  SendApi sendApi = SendApi();

  @override
  void initState() {
    super.initState();
    // 데이터를 가져오는 함수 호출. init 부분에서 시행한다.
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // API 요청을 보냅니다.
      final value = await httpPut(path: '/api/users/2', data: sendApi.toJson());

      if (value == 201) { //put
        // 성공적으로 응답을 받았을 때 FinishExchange 화면으로 이동합니다.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinishExchange()),
        );
      } else {
        print(value);
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        // 에러가 발생하면 에러 메시지를 출력합니다.
        // 이 경우에는 화면 전환이 필요하지 않으므로 setState()는 호출하지 않습니다.
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
      // 에러가 발생하면 에러 메시지를 출력합니다.
      // 이 경우에는 화면 전환이 필요하지 않으므로 setState()는 호출하지 않습니다.
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return WillPopScope(
      onWillPop: () async {
        return false; // 화면을 떠나지 않도록 false를 반환합니다.
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFFFBD3),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '화면을 끄지 마시고',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.03,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '잠시 기다려 주세요!',
                style: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: 25,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.03,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: screenWidth * 0.5,
                width: screenWidth * 0.5,
                child: Lottie.asset("assets/lottie/loading.json"),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${userData.lastName}',
                      style: TextStyle(
                        color: Color(0xFFFF8D4D),
                        fontSize: 25,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.03,
                      ),
                    ),
                    TextSpan(
                      text: '님에게',
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: 25,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.03,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '매듭을 보내고 있습니다..',
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: 25,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.03,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}